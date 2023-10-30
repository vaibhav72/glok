class MetaStrings {
  static const String baseUrl = 'http://dev.mindstack.in:3030';

  static const String agoraAppid = '0a53e73e1beb4f1887eaa84cfcb37bd9';
  static const String testingToken =
      '007eJxTYDhteXe1jvcJG1d/tWrp5FNbA55fLZqUY2VU3z5/y4bjN8MVGAwMTY2MDJJMzVKMzUwMDU0Sk4yNLE1SLC0sEi3Nzc1TTc5bpTYEMjL43/nAwsgAgSA+O0NJanFJZl46AwMAnpIgpA==';
  static const String testingChannelName = 'testing';

  ///registration Urls
  static const String userRegistrationUrl = '/user/new';
  static const String verifyMobile = '/user/verifyMobile';
  static const String getCurrentuser = '/user/currentbyuser';
  static const String updateUser = '/user';
  static const String generateOtp = '/auth/generateOtp';
  static const String loginVerifyOTP = '/auth/verifymobileotp';
  static const String changeGlockerMode = '/user/updateisglocker';

  static const String updateUserPhoto = '/user/photo';
  static const String changeuserType = '/user/updateisglocker';
  static const String createuserNotification = '/user-notification/new';
  static const String updateNotification = '/user-notification/update';

  //glocker

  static const String getCurrentGlocker = '/glocker/currentglocker';
  static const String glockerNew = '/glocker/new';
  static const String glockerUpdate = '/glocker/update';
  static const String updateGlockerPhoto = '/glocker/updateprofilephoto';
  static const String updateGlockerCoverPhoto = '/glocker/updatecoverphoto';
  static const String updateAadharFile = '/glocker/updateaadharfile';
  static const String updateVideKYC = '/glocker/updatevideokyc';
  static const String glockerUserStatistics = '/glocker/statistics';
  static const String updateOnlineStatus = '/glocker/online_status';

  //glocker list sort
  static const String getGlocker = '/glocker/';
  static const String getGlockerSort = '/glocker/sort';
  static const String getFilteredGlocker = '/glocker';

  static const String model = 'Model';
  static const String influencer = 'Influencer';
  static const String movieStar = 'MovieStar';
  static const String internationalStar = 'InternationalStar';

//bank

  static const String updatebank = '/bank';
  //gallery

  static const String updateGalleryPhoto = '/gallery/photo';
  static const String updateGalleryVideo = '/gallery/video';
  static const String getMyGallery = '/gallery';
  static const String getGlockerGallery = '/gallery/user/';

  //favorites
  static const String getFavorites = '/favourite';
  static const String updateFavorites = '/favourite/fav';

  //rating
  static const String updateUserRating = '/rating/';
  static const String updateGlockerRating = '/glokrating';

  //money
  static const String addFunds = '/money/addfund';
  static const String withdrawFunds = '/money/withdraw';
  static const String getAllTransactions = '/money/';
  static const String getWalletDetails = '/wallet/currentwallet';

  //video call
  static const String getVideoCall = '/videocall';

  static const String endCall = '/videocall/disconnect';
  static const String getAgoraToken = '/agora/token';

  //bid
  static const String bidNew = '/bid/new';
  static const String cancelBid = '/bid/cancelbid';
  static const String bidList = '/bid/bidlist';
  static const String acceptCall = '/bid/acceptcall';
}
