# frozen_string_literal: true

module Constants
  INT_MAX = (2**(64 - 2)) - 1
  INT_MIN = -INT_MAX - 1

  SUPERSCRIPT_NUM = {
    0 => "\u2070",
    1 => "\u00B9",
    2 => "\u00B2",
    3 => "\u00B3",
    4 => "\u2074",
    5 => "\u2075",
    6 => "\u2076",
    7 => "\u2077",
    8 => "\u2078",
    9 => "\u2079"
  }.freeze
end
