import 'package:get/get.dart';
import 'package:nuritopia2d/app/modules/validate_user/binding/validate_user_binding.dart';
import 'package:nuritopia2d/app/modules/validate_user/views/validate_user_view.dart';
import 'package:nuritopia2d/app/routes/routes.dart';
import '../modules/edit_profile/binding/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/events/binding/events_binding.dart';
import '../modules/home/binding/home_binding.dart';
import '../modules/events/views/all_events_view.dart';
import '../modules/home/binding/rap_binding.dart';
import '../modules/home/views/buy_ticket/buy_ticket_view.dart';
import '../modules/home/views/buy_ticket/buy_tickets_details_view.dart';
import '../modules/home/views/challange/instruction_view_screen.dart';
import '../modules/home/views/challange/take_a_challenge_view.dart';
import '../modules/home/views/connect_with_person.dart';
import '../modules/home/views/drawer/change_password_view.dart';
import '../modules/home/views/home_screen.dart';
import '../modules/home/views/reward_account/reward_account_added_succesfull.dart';
import '../modules/home/views/reward_account/rewarded_account_page.dart';
import '../modules/invite_friends/binding/invite_friend_binding.dart';
import '../modules/invite_friends/views/invite_friend_view.dart';
import '../modules/language/binding/language_binding.dart';
import '../modules/language/views/language_selection_screen.dart';
import '../modules/login/binding/login_binding.dart';
import '../modules/login/views/login_screen.dart';
import '../modules/splash/presentation/binding/splash_binding.dart';
import '../modules/splash/presentation/views/splash_screen.dart';
import '../modules/voting/binding/vote_binding.dart';
import '../modules/voting/views/do_not_have_enough_token_view.dart';
import '../modules/voting/views/successfully_sibmitted_vote_screen.dart';
import '../modules/voting/views/vote/voting_view_screen.dart';
import '../modules/voting/views/winners/check_for_winners_view.dart';
import '../modules/voting/views/winners/winner_details_view.dart';
import '../modules/wallet/binding/wallet_binding.dart';
import '../modules/wallet/views/wallet_buy_toss_transanction_password_confirm_view.dart';
import '../modules/wallet/views/wallet_view.dart';


class Theme1AppPages {
  static const INITIAL = Routes.ROOT;
   static const INITIAL_FOR_LOGIN = Routes.LOGIN;
  static final routes = [
    GetPage(
        name: Routes.ROOT,
        page: () => const SplashScreen(),
      binding: SplashBinding(),
       ),
    GetPage(
      name: Routes.LOGIN,
      page: () =>  LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () =>  HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.TAKECHALLENGE,
      page: () =>  TakeAChallenge(),
      binding: RapBinding(),
    ),
    GetPage(
      name: Routes.CHECKWINNER,
      page: () =>  CheckForWinnersView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.ALLEVENTS,
      page: () =>  AllEventsViewScreen(),
      binding: EventsBinding(),
    ),
    GetPage(
      name: Routes.BUYTICKET,
      page: () =>  BuyTicketView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.EDITPROFILE,
      page: () =>  EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: Routes.VALIDATEUSERVIEW,
      page: () =>  ValidateUserView(),
      binding: ValidateUserBinding(),
    ),
    GetPage(
      name: Routes.CHANGEPASSWORD,
      page: () =>  ChangePasswordView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.WALLET,
      page: () =>  WalletView(),
      binding: WalletBinding(),
    ),
    GetPage(
      name: Routes.REWARDEDACCOUNT,
      page: () =>  RewardedAccountView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.WALLETBUYTOSSTRANSACTIONPASSWORDCONFIRMVIEW,
      page: () =>  WalletBuyTossTransactionPasswordConfirmView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.BUYTICKETSDETAILSVIEW,
      page: () =>  BuyTicketsDetailsView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.WINNERDETAILSVIEW,
      page: () =>  WinnerDetailsView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.INVITEFRIEND,
      page: () =>  InviteFriendView(),
      binding: InviteFriendBinding(),
    ),
    GetPage(
      name: Routes.INSTRUCTIONVIEW,
      page: () =>  InstructionViewScreen(),
      binding: RapBinding(),
    ),
    GetPage(
      name: Routes.VOTINGSCREEN,
      page: () =>  VotingViewScreen(),
      binding: VoteBinding(),
    ),
    GetPage(
      name: Routes.VOTESUBMITTEDSUCCESSFULL,
      page: () =>  SuccessfullySubmittedVotedScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.CONNECTWITHPERSON,
      page: () =>  ConnectWithPersonScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.REWARDACCOUNTADDEDSUCCESSFULLY,
      page: () =>  RewardAccountAddedSuccessfully(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.DONOTHAVEENOUGHTOKENFORVOTE,
      page: () =>  DoNotHaveEnoughTokenView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.LANGUAGESELECTIONSCREEN,
      page: () =>  LanguageSelectionScreen(),
      binding: LanguageBinding(),
    ),
  ];
}