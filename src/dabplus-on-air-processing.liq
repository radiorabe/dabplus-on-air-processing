# DAB+ On Air Processing for Radio Bern RaBe

log("RaBe DAB+ On Air Processing starting",label="dabplus")

if not file.exists("/etc/liquidsoap/dabplus-on-air-processing.conf") then
  log("Could not find /etc/liquidsoap/dabplus-on-air-processing.conf", label="dabplus", level=0)
  shutdown()
end
%include "/etc/liquidsoap/dabplus-on-air-processing.conf"

# prepare possible input
alsa = input.alsa()
stream = mksafe(input.http(source_stream_url))
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

output =
  if enable_processor then
    log("Audio Processor enabled", label="dabplus")
    # let processor from lib handle processing
    %include <process.liq>
    output
  else
    log("Audio Processor disabled", label="dabplus")
    input
  end

# send the processed signal to the encoder
output.external(
  wav_encoder,
  external_encoder,
  output)

# write archive files if feature is enabled
if enable_archive then
  log("Archive enabled and writing to #{archive_path}", label="dabplus")
  ignore(output.file(
    archive_encoder,
    archive_path,
    reopen_when={0m0s},
    output))
end
