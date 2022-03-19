const invitedUsersContainer = document.querySelector('#invited-users-container');
const privacyContainer = document.querySelector('#privacy-container');

const toggleInvitedUsers = function(e) {
  eventPrivacy = e.target.value;

  if (eventPrivacy === 'true') {
    invitedUsersContainer.classList.remove('hidden');
  } else {
    invitedUsersContainer.classList.add('hidden');
  }
};

invitedUsersContainer.classList.add('hidden');
privacyContainer.addEventListener('change', toggleInvitedUsers);
