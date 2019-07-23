import logging
from dataclasses import dataclass

import webrtcvad

logger = logging.getLogger(__name__)


# WebRTC VAD only supports 16-bit mono PCM audio
SAMPLE_WIDTH_IN_BYTES = 2
NUM_CHANNELS = 1


@dataclass
class Parameter:
  # The frame rate of the audio being processed
  audio_frame_rate: int

  # Parameters for WebRTC VAD
  # See https://github.com/wiseman/py-webrtcvad for more details
  #
  # The WebRTC VAD only accepts 16-bit mono PCM audio,
  # sampled at 8000, 16000, 32000 or 48000 Hz.
  #
  # A frame must be either 10, 20, or 30 ms in duration.
  #
  # WebRTC VAD has an aggressiveness mode, which is an integer between 0 and 3.
  # 0 is the least aggressive about filtering out non-speech, 3 is the most aggressive.
  webrtcvad_mode: int
  webrtcvad_duration_in_ms: int

  window_size_in_blocks: int
  cluster_threshold: float
  stride_in_blocks: int
  split_threshold_in_blocks: int
  drop_threshold_in_blocks: int


class Splitter:

  def __init__(self, parameter: Parameter):
    self._parameter = parameter

    self._vad = webrtcvad.Vad()
    self._vad.set_mode(parameter.webrtcvad_mode)

  def update(self, audio_binary: bytes):
    pass