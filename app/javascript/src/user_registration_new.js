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

selectOffset(); // this line & above needs refactoring too

const updateTimeSpan = function() {
  const offsetNumberRegex = /[+-]*\d+/g;
  const currentTimeSpan = document.getElementById('dynamic_time');

  const selectedOptionIndex = timeZoneDropdown.selectedIndex;
  const selectedTimeZoneOption = timeZoneDropdown.children[selectedOptionIndex];
  const selectedOffset = selectedTimeZoneOption
    .textContent
    .match(offsetRegex)[0];
  const selectedOffsetNumber = selectedTimeZoneOption
    .textContent
    .match(offsetNumberRegex);
  const selectedOffsetHour = parseInt(selectedOffsetNumber[0]);
  const selectedOffsetMinute = parseInt(selectedOffsetNumber[1]);

  const localOffsetNumber = offset.match(offsetNumberRegex);
  const localOffsetHour = parseInt(localOffsetNumber[0]);
  const localOffsetMinute = parseInt(localOffsetNumber[1]);

  const currentDate = new Date();
  const formatter = new Intl.DateTimeFormat('en-US', {
    hour: '2-digit',
    minute: '2-digit',
  });

  // make selected minutes negative if the hours are negative
  let minute;
  if (selectedOffsetHour < 0) {
    minute = -(selectedOffsetMinute);
  } else {
    minute = selectedOffsetMinute;
  }

  // if localOffset x is negative
  if (localOffsetHour < 0) {
    const localToUTCHours = currentDate.getUTCHours() + Math.abs(localOffsetHour);
    const localToUTCMinutes = currentDate.getUTCMinutes() + Math.abs(localOffsetMinute);

    // UTC is x hours AHEAD, so add positive x local offset to UTC hour
    // to convert user local time to UTC-equivalent
    // then subtract the selected offset
    // to represent current time in selected offset, regardless of local time zone
    // set this as the new UTC time which gets converted to local time
    // but is now properly offset (according to the selected time zone)
    currentDate.setUTCHours(
      localToUTCHours + selectedOffsetHour,
      localToUTCMinutes + minute);
  } else {
    const localToUTCHours = currentDate.getUTCHours() - Math.abs(localOffsetHour);
    const localToUTCMinutes = currentDate.getUTCMinutes() - Math.abs(localOffsetMinute);

    currentDate.setUTCHours(
      localToUTCHours + selectedOffsetHour,
      localToUTCMinutes + minute);
  }

  currentTimeSpan.textContent = `${formatter.format(currentDate)} (${selectedOffset})`;

  /* whole function needs refactoring */
  // change let to constants?
};

timeZoneDropdown.addEventListener('change', updateTimeSpan);
updateTimeSpan();
