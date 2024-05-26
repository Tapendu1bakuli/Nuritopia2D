class Urls {
  //base urls for development
  //mock base url
  //static const baseUrl = "b6a9b7df-1417-4648-8603-8ac1e913878a.mock.pstmn.io";
  //Dev base url
  static const baseUrl = "";
  static const baseUrlInviteFriend =
      "";
  static const API = "/api/v1/";
  static const APIV2 = "/api/v2/";
  static const String GOOGLE = "google.com";
  //base urls for staging
  //static const baseUrl = "stagingapi.lightforth.ai";

  //linkdin redirect url for devlopment
  static const linkdinRedirect = '';
  //linkdin redirect url for staging
  // static const linkdinRedirect = 'https://staging.lightforth.ai/student/login';
  //Login using google token
  static const googleLogin = "AuthSendGoogleIdToken";
  //Load home user details
  static const userDetails = "getUserDetails";
  //Load events
  static const allEvents = "getEventList";
  //Get slider
  static const getSlider = "sliders";
  //Get rewards Strings
  static const inviteFriend = "inviteFriend";
  //Get rewards Strings
  static const logout = "logout";
  //Authenticate referral
  static const authenticateReferral = "authenticateReferralcode";
  //Check winners list
  static const checkWinnerDance = "searchWinningList";
  //Search winners list
  static const searchWinnerDance = "searchWinningList";
  //Check winners list
  static const rewardAccount = "paymentAccountTypes";
  //Delete Account
  static const deleteAccount = "deleteUser";
  //Get wallet details
  static const getWalletDetails = "getWalletDetails";
  //Save Reward Account details
  static const userPaymentAccountSave = "v2/userPaymentAccountSave";
  //Transaction List details
  static const userTransctionList = "walletHistory";
  //Get Dance Voting Video
  static const getDanceVotingVideo = "getDanceVotingVideo";
  //Get Dance Voting Video
  static const getRapVotingVideo = "getSingingVotingVideo";
  //Get Performer Details
  static const getPerformerDetails = "getPerformerDetails";
  //Submit Voting Details
  static const submitVotingDetails = "submitVotingDetails";
  //Get dance music track
  static const getDanceMusicTrack = "getDanceMusicTrack";
  //Get music track
  static const getMusicTrack = "getMusicTrack";
  //Get music track
  static const submitVideo = "submitUserUploadedVideo";
  //Apple Login
  static const appleLogin = "AuthSendAppleIdToken";

  //user verification with nuritopia
  static const userVerification = "userVerification";

  //Events get cities
  static const String APIKEY =
      "NXFKQWVvemEwR1JtOHFkQnJrTVZaa1lyRmVkUzloQk82b0pMZ2tLZg==";
  static const String CITY_BASE_URL = "api.countrystatecity.in";
  static const String CITY_API_V1 = "v1/countries/";
  static const String CITY_END_POINT = "/cities";

  //AWS SETUP Development
  static const String streamVideoBaseUrl =
      '';
  static const String accessKeyId = '';
  static const String secretKeyId = '';
  static const String region = '';
  static const String s3BucketName = '';
  static const String s3Endpoint =
      '';
  static const String s3UploadedURL =
  "";
}
