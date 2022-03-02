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
  const currentTimeSpan = document.getElementById('dynamic_time');
  let selectedOptionIndex = timeZoneDropdown.selectedIndex;
  let selectedTimeZoneOption = timeZoneDropdown.children[selectedOptionIndex];
  let selectedOffset = selectedTimeZoneOption
    .textContent
    .match(offsetRegex)[0];

  const offsetNumberRegex = /[+-]*\d+/g;
  let selectedOffsetNumber = selectedTimeZoneOption
    .textContent
    .match(offsetNumberRegex);
  let localOffsetNumber = offset.match(offsetNumberRegex);

  let currentDate = new Date();
  const formatter = new Intl.DateTimeFormat('en-US', {
    hour: '2-digit',
    minute: '2-digit',
  });

  // make selected minutes negative if the hours are negative
  let minute;
  if (parseInt(selectedOffsetNumber[0]) < 0) {
    minute = -(parseInt(selectedOffsetNumber[1]));
  } else {
    minute = parseInt(selectedOffsetNumber[1]);
  }

  // if localOffset x is negative
  if (parseInt(localOffsetNumber[0]) < 0) {
    // UTC is x hours AHEAD, so add positive x local offset to UTC hour
    // to convert user local time to UTC-equivalent
    // then subtract the selected offset
    // to represent current time in selected offset, regardless of local time zone
    // set this as the new UTC time which gets converted to local time
    // but is now properly offset (according to the selected time zone)
    currentDate.setUTCHours(
      currentDate.getUTCHours() +
      Math.abs(parseInt(localOffsetNumber[0])) +
      parseInt(selectedOffsetNumber[0]),
      currentDate.getUTCMinutes() +
      Math.abs(parseInt(localOffsetNumber[1])) +
      minute);
  } else {
    currentDate.setUTCHours(
      currentDate.getUTCHours() -
      Math.abs(parseInt(localOffsetNumber[0])) +
      parseInt(selectedOffsetNumber[0]),
      currentDate.getUTCMinutes() -
      Math.abs(parseInt(localOffsetNumber[1])) +
      minute);
  }

  currentTimeSpan.textContent = `${formatter.format(currentDate)} (${selectedOffset})`;

  /* whole function needs refactoring */
  // change let to constants?
};

timeZoneDropdown.addEventListener('change', updateTimeSpan);
updateTimeSpan();
