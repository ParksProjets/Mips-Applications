"""

LpSolve wrapper.

Copyright (C) 2018, Guillaume Gonnet
License MIT

"""

from ctypes import *
import sys
import os.path as path
import platform


# Import the DLL
ver = ("x86", "x64")[sys.maxsize > 2**32]
here = path.dirname(__file__)

if sys.platform == "win32":
    lib = windll.LoadLibrary(path.abspath(path.join(here, "dll/lpsolve55-%s.dll" % ver)))
elif sys.platform == "linux":
    lib = cdll.LoadLibrary(path.abspath(path.join(here, "dll/lpsolve55-%s.so" % ver)))
else:
    raise ValueError("Can't load LpSolve library on this platform.")


# Make the bindings
c_double_p = POINTER(c_double)
c_int_p = POINTER(c_int)

lib.make_lp.argtypes = [c_int, c_int]
lib.make_lp.restype = c_void_p

lib.delete_lp.argtypes = [c_void_p]

lib.set_binary.argtypes = [c_void_p, c_int, c_ubyte]
lib.set_binary.restype = c_ubyte

lib.set_int.argtypes = [c_void_p, c_int, c_ubyte]
lib.set_int.restype = c_ubyte

lib.add_constraintex.argtypes = [c_void_p, c_int, c_double_p, c_int_p, c_int, c_double]
lib.add_constraintex.restype = c_ubyte

lib.set_obj_fnex.argtypes = [c_void_p, c_int, c_double_p, c_int_p]
lib.set_obj_fnex.restype = c_ubyte

lib.set_add_rowmode.argtypes = [c_void_p, c_ubyte]
lib.set_add_rowmode.restype = c_ubyte

lib.set_maxim.argtypes = [c_void_p]

lib.write_lp.argtypes = [c_void_p, c_char_p]
lib.write_lp.restype = c_ubyte

lib.set_verbose.argtypes = [c_void_p, c_int]

lib.solve.argtypes = [c_void_p]
lib.solve.restype = c_int

lib.get_variables.argtypes = [c_void_p, c_double_p]
lib.get_variables.restype = c_ubyte



class LpEngine(object):
    "The Linear Programming Engine."

    def __init__(self, maxvars, debug=False):
        self.debug = debug

        self.maxvars = maxvars
        self.vars = []

        self.lp = lib.make_lp(0, maxvars)
        assert self.lp != 0, "Can't construct a new LpSolve model"

        self.colbuff = (c_int * maxvars)()
        self.rowbuff = (c_double * maxvars)()

        lib.set_add_rowmode(self.lp, 1)


    def __del__(self):
        lib.delete_lp(self.lp)


    def constraint(self, const):
        "Add a new constraint into the model."

        assert const.optype is not None, "You must provide the RHS of constraint"
        const.fill_buffers(self.colbuff, self.rowbuff)

        ret = lib.add_constraintex(self.lp, len(const.vars), cast(self.rowbuff, c_double_p),
            cast(self.colbuff, c_int_p), const.optype, const.rhs)
        assert ret == 1, "Can't add constraint into model"


    def objective(self, const):
        "Set the objective function."

        lib.set_add_rowmode(self.lp, 0)
        const.fill_buffers(self.colbuff, self.rowbuff)

        ret = lib.set_obj_fnex(self.lp, len(const.vars), cast(self.rowbuff, c_double_p),
            cast(self.colbuff, c_int_p))
        assert ret == 1, "Can't set objective function of model"


    def update_variables(self):
        "Update the variable values."

        ret = lib.get_variables(self.lp, cast(self.rowbuff, c_double_p))
        assert ret == 1, "Can't get variable values"

        for i, var in enumerate(self.vars):
            var.value = self.rowbuff[i]


    def solve(self):
        "Solve the model."

        lib.set_maxim(self.lp)
        if self.debug:
            lib.write_lp(self.lp, b"debug-model.lp")
        else:
            lib.set_verbose(self.lp, 3)

        ret = lib.solve(self.lp)
        if ret == 0 or ret == 1:
            self.update_variables()
        return ret




class LpVariable(object):
    "A LpSolve variable."

    def __init__(self, lp, vtype="real"):
        assert len(lp.vars) < lp.maxvars, "Can't add a variable: "

        self.index = len(lp.vars) + 1
        self.value = None

        self.lp = lp
        lp.vars.append(self)

        self.type = "real"
        self.retype(vtype)


    def retype(self, vtype):
        "Change the type of the variable"

        if "bin" in (self.type, vtype):
            lib.set_binary(self.lp.lp, self.index, (vtype == "bin"))
        elif "int" in (self.type, vtype):
            lib.set_binary(self.lp.lp, self.index, (vtype == "int"))


    def __rmul__(self, num):
        return LpConstraint([num], [self])


    def __add__(self, other):
        if isinstance(other, LpConstraint):
            return other.__add__(self)
        return LpConstraint([1, 1], [self, other])




class LpConstraint(object):
    "A LpSolve constraint."

    def __init__(self, numbers, vars):
        self.numbers = numbers
        self.vars = vars

        self.optype = None
        self.rhs = None


    def fill_buffers(self, colno, row):
        "Fill colno and row buffers for calling LpSolve."

        for i, (num, var) in enumerate(zip(self.numbers, self.vars)):
            colno[i] = var.index
            row[i] = num


    def __add__(self, other):
        if isinstance(other, LpVariable):
            return LpConstraint(self.numbers + [1], self.vars + [other])
        else:
            c = LpConstraint(self.numbers + other.numbers, self.vars + other.vars)
            assert len(c.vars) == len(set(c.vars)), "Some variables appear several times"
            return c


    def __le__(self, val):
        self.optype, self.rhs = (1, val)
        return self

    def __eq__(self, val):
        self.optype, self.rhs = (3, val)
        return self

    def __ge__(self, val):
        self.optype, self.rhs = (2, val)
        return self
