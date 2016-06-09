local ffi = require "ffi"

local mundos_posibles = 5

ffi.cdef[[
void Sleep(int ms);
int poll(struct pollfd *fds, unsigned long nfds, int timeout);
]]

if ffi.os == "Windows" then
 function sleep(s)
    ffi.C.Sleep(s*1000)
  end
else
  function sleep(s)
    ffi.C.poll(nil, 0, s*1000)
  end
end

local nec = function (A)
    AI = {}
    AI[1] = A[1] * A[3] * A[5]
    AI[2] = A[2] * A[1] * A[1]
    AI[3] = A[3] * A[5] * A[4]
    AI[4] = A[4] * A[5]
    AI[5] = 1
    return AI
end

local pos = function (A)
  local res = mnot(nec(mnot(A)))
  return res
end

local ctrue  = function () return 1 end -- tautología
local cfalse = function () return 0 end -- contradicción
local cnot   = function (a) return 1 - a end -- negación
local cand   = function (a, b) return math.min(a, b) end
local cor    = function (a, b) return math.max(a, b) end
local cimp   = function (a, b) return b >= a and 1 or 0 end -- implicación

local mmap = function (clf, A, B)
    C = {}
    for i=1,mundos_posibles do C[i] = clf(A and A[i], B and B[i]) end
    return C
  end

local mtrue  = function () return mmap(ctrue)  end
local mfalse = function () return mmap(cfalse) end
local mand   = function (A, B) return mmap(cand, A, B) end
local mor    = function (A, B) return mmap(cor,  A, B) end
local mimp   = function (A, B) return mmap(cimp, A, B) end
local mnot   = function (A)    return mmap(cnot, A) end

local sistema = nec{1,0,1,0,1} -- evalúa sistema

for c,v in ipairs(sistema) do
  local file = io.open("ruta de archivo","w")
  file:write(v)
  file:close()
  print(v)
  sleep(1)
end
