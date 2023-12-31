String baseUrl = "https://mistrichacha.com/";
String loginApiUrl = 'tsit/Fsm/FsmLogin';
String registrationUrl = 'tsit/Fsm/registerServicePartnerNew';
String sendOtp = "tsit/Fsm/SendOtpToServicePartner";
String getCountry = "tsit/Fsm/getAllCountry";
String getCostomServiceList = "tsit/Fsm/getAllCustomServices";
String forgotResetLink = "tsit/Fsm/FsmForgetPassword";
String getProfileInfo = "tsit/Fsm/getFsmProfileDetails";
String updateProfile = "tsit/Fsm/UpdateFsmProfile";
String getClientList = "tsit/Fsm/getClientList";
String addClient = "tsit/Fsm/addClientRequest";
String getLineList = "tsit/Fsm/getLineItemList";
String addLineListItem = "tsit/Fsm/addLineItem";
String getQuoteList = "tsit/Fsm/quoteList";

class ApisPath {
  String postLogin = baseUrl + loginApiUrl;
  String postRegistrationUrl = baseUrl + registrationUrl;
  String postOtp = baseUrl + sendOtp;
  String postCountry = baseUrl + getCountry;
  String postGetCostomeServiceList = baseUrl + getCostomServiceList;
  String postForgotResetLink = baseUrl + forgotResetLink;
  String postGetProfileInfo = baseUrl + getProfileInfo;
  String updateProfileInfo = baseUrl + updateProfile;
  String getClientListData = baseUrl + getClientList;
  String postAddClientToDb = baseUrl + addClient;
  String postGetLineList = baseUrl + getLineList;
  String postAddItemLine = baseUrl + addLineListItem;
  String postGetQuoteList = baseUrl + getQuoteList;
}

