live_loop :foo do
  use_synth :pluck
  a = File.open("ruta de archivo","r")
  nota = a.read
  ##b = nota.split(",").map { |s| s.to_i }
  ##c = choose([60,67,63])
  print(nota.to_f)
  if nota.to_f > 0
    play nota.to_f, release: 0.5, decay: 0.4
  end
  ##a.write(c/50)
  ##print(c)
  sleep 0.25
  ##a.close
end

##live_loop :bar do
##sync :foo
##sample :bd_haus
##sleep 0.5
##sample :drum_snare_hard
##sleep 0.5
##end
