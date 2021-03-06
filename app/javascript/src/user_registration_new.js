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

  if (matchingOffsetOption === undefined) {
    timeZoneDropdown.value = 'UTC';
  } else {
    timeZoneDropdown.value = matchingOffsetOption.value;
  }
};

const updateTimeSpan = function() {
  const offsetNumbersRegex = /[+-]*\d+/g;
  const currentTimeSpan = document.getElementById('dynamic_time');

  const selectedOptionIndex = timeZoneDropdown.selectedIndex;
  const selectedTimeZoneOption = timeZoneDropdown.children[selectedOptionIndex];
  const selectedOffset = selectedTimeZoneOption
                         .textContent
                         .match(offsetRegex)[0];
  const selectedOffsetNumbers = selectedTimeZoneOption
                                .textContent
                                .match(offsetNumbersRegex);
  const selectedOffsetHours = parseInt(selectedOffsetNumbers[0]);
  let selectedOffsetMinutes = parseInt(selectedOffsetNumbers[1]);

  const localOffsetNumbers = offset.match(offsetNumbersRegex);
  const localOffsetHours = parseInt(localOffsetNumbers[0]);
  const localOffsetMinutes = parseInt(localOffsetNumbers[1]);

  const currentDate = new Date();
  const formatter = new Intl.DateTimeFormat('en-US', {
    hour: '2-digit',
    minute: '2-digit',
  });

  if (selectedOffsetHours < 0) {
    selectedOffsetMinutes = -selectedOffsetMinutes;
  }

  /*
   * if localOffset x is negative
   * UTC is x hours AHEAD, so add positive x local offset to UTC hour
   * to convert user local time to UTC-equivalent
   *
   * then subtract the selected offset
   * to represent current time in selected offset, regardless of local time zone
   *
   * set this as the new UTC time which gets converted to local time
   * but is now properly offset (according to the selected time zone)
   */

  if (localOffsetHours < 0) {
    const localToUTCHours = currentDate.getUTCHours() + Math.abs(localOffsetHours);
    const localToUTCMinutes = currentDate.getUTCMinutes() + Math.abs(localOffsetMinutes);

    currentDate.setUTCHours(
      localToUTCHours + selectedOffsetHours,
      localToUTCMinutes + selectedOffsetMinutes);
  } else {
    const localToUTCHours = currentDate.getUTCHours() - Math.abs(localOffsetHours);
    const localToUTCMinutes = currentDate.getUTCMinutes() - Math.abs(localOffsetMinutes);

    currentDate.setUTCHours(
      localToUTCHours + selectedOffsetHours,
      localToUTCMinutes + selectedOffsetMinutes);
  }

  currentTimeSpan.textContent = `${formatter.format(currentDate)} (${selectedOffset})`;
};

timeZoneDropdown.addEventListener('change', updateTimeSpan);
selectOffset();
updateTimeSpan();
