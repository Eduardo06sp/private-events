const currentDate = Date.now();
const timeAndZoneFormat = new Intl.DateTimeFormat('en-US', {
  hour: '2-digit',
  minute: '2-digit',
  timeZoneName: 'long'
});
const timeAndZone = timeAndZoneFormat.format(currentDate);

const time = timeAndZone.slice(0, 8);
const zone = timeAndZone.slice(9);
