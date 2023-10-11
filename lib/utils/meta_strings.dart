class MetaStrings {
  static const String baseUrl = 'http://dev.mindstack.in:3030';

  ///registration Urls
  static const String userRegistrationUrl = '/user/new';
  static const String verifyMobile = '/user/verifyMobile';
  static const String getCurrentuser = '/user/currentbyuser';
  static const String updateUser = '/user';
  static const String generateOtp = '/auth/generateOtp';
  static const String loginVerifyOTP = '/auth/verifyOtp';

  static const String updateUserPhoto = '/user/photo';
  static const String changeuserType = '/user/updateisglocker';
  static const String createuserNotification = '/user-notification/new';
  static const String updateNotification = '/user-notification/update';

  //glocker
  static const String getCurrentGlocker = '/glocker/';
  static const String glockerNew = '/glocker/new';
  static const String glockerUpdate = '/glocker/update';
  static const String updateGlockerPhoto = '/glocker/updateprofilephoto';
  static const String updateGlockerCoverPhoto = '/glocker/updatecoverphoto';
  static const String updateAadharFile = '/glocker/updateaadharfile';
  static const String updateVideKYC = '/glocker/updatevideokyc';
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
  static const String getFavorites = '/favorite';
  static const String updateFavorites = '/favorite/fav';

  //rating
  static const String updateUserRating = '/rating';
  static const String updateGlockerRating = '/glokrating';

  //money
  static const String addFunds = '/money/addfund';
  static const String withdrawFunds = '/money/withdraw';
  static const String getAllTransactions = '/money';

  //video call
  static const String getVideoCall = '/videocall';
  static const String endCall = '/videocall/disconnect';
  static const String getAgoraToken = '/agora/token';

  //bid
  static const String bidNew = '/bid/new';
  static const String bidList = '/bid/bidlist';
  static const String acceptCall = '/bid/acceptcall';
}
