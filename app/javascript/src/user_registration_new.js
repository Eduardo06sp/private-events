const getTimeAndOffset = function() {
  const currentDate = Date.now();
  const timeAndOffsetFormat = new Intl.DateTimeFormat('en-US', {
    hour: '2-digit',
    minute: '2-digit',
    timeZoneName: 'longOffset'
  });

  return timeAndOffsetFormat.format(currentDate);
};

const timeAndOffset = getTimeAndOffset();
const time = timeAndOffset.slice(0, 8);
const offset = timeAndOffset.slice(9);

const timeZoneDropdown = document.getElementById('user_time_zone');
const timeZoneOptions = Array.from(timeZoneDropdown.children);
const offsetRegex = /GMT.*\d/g;

const selectOffset = function() {
  const matchingOffsetOption = timeZoneOptions.find( (option) => {
    const currentOffset = option.textContent.match(offsetRegex)[0];
    return currentOffset === offset;
  });

  timeZoneDropdown.value = matchingOffsetOption.value;
};

selectOffset();
