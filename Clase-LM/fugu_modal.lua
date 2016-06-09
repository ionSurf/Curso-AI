module(...,package.seeall)

local m, vs, col
local direc = "ruta de archivo"
local valores

function setup()
	m = dodecahedron()
  --m:subdivide(3)
	fgu:add(meshnode(m))
	vs = vertexlist(m)
end

function update(dt)
 
  valores = leer(direc)
 
  if #valores > 0 then
  
    each(vs, function(v)
        local pos = v:getPos()
			  local  v.c = col(pos.y,pos.x,pos.z,fgu.t)
    end)
	
    each(vs, function (v)
        local pos = v.p
        local p = perturb(tan(pos.x),pos.y,pos.z, fgu.t)		
        local pv = random_vec3(sin((dt+p)*(valores)/100))
        v.p = pos + pv
        end)
	
  --print(value)
 
  end

end

leer = function (dir)
 local file = io.open(dir,"r")
 local lee = file:read "*all"
 return lee
end

col = function(x,y,z,t) 
	return vec3(
		noise(x+cos(t),y/cos(t),z),
		0,		
		noise(x-cos(t),t/y,z+t)
		) 
end

perturb = function(x,y,z,t) 
	return noise(x*cos(t),y*tan(t),z+sin(t)) 
end
