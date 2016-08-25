# DAB+ On Air Processing for Radio Bern RaBe

log("RaBe DAB+ On Air Processing starting",label="dabplus")

if not file.exists("/etc/liquidsoap/dabplus-on-air-processing.conf") then
  log("Could not find /etc/liquidsoap/dabplus-on-air-processing.conf", label="dabplus", level=0)
  shutdown()
end
%include "/etc/liquidsoap/dabplus-on-air-processing.conf"

# prepare possible input
alsa = input.alsa()
stream = mksafe(playlist(source_stream_url))
safe_empty = mksafe(empty())

# use configured input as input to processor
input = 
  if source_type == "alsa" then
    log("Using alsa source", label="dabplus")
    alsa
  elsif source_type == "stream" then
    log("Using stream source", label="dabplus")
    log(source_stream_url, label="dabplus")
    stream
  else
    log("No source specified", label="dabplus")
    shutdown()
    safe_empty
  end

# let external processor handle processing
%include "process.liq"

# send the processed signal to the encoder
output.external(
  wav_encoder,
  external_encoder,
  output)
