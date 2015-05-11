function signinCallback(authResult) {
  if (authResult['status']['signed_in']) {
    var ACCESSTOKEN = authResult['access_token']
    console.log(ACCESSTOKEN)
    document.getElementById('signinButton').setAttribute('style', 'display: none');
  } else {
    console.log('Sign-in state: ' + authResult['error']);
  }
}

