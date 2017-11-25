def format_time time
  return 'Rang!' if time < 0
  '%02d:%02d' % [time/60, time%60]
end
def remainig_time ring_time, now
  Time.parse(ring_time) - Time.parse(now)
end
def formatted_remaining_time ring_time, now
  format_time remainig_time ring_time, now
end

