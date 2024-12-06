import 'package:emptychair/features/screens/admin/add_barber.dart';
import 'package:emptychair/features/screens/admin/admin_only.dart';
import 'package:emptychair/features/screens/admin/app_info.dart';
import 'package:emptychair/features/screens/admin/barber_clock.dart';
import 'package:emptychair/features/screens/admin/barber_dash.dart';
import 'package:emptychair/features/screens/admin/checkin/list.dart';
import 'package:emptychair/features/screens/admin/checkin/select_barber.dart';
import 'package:emptychair/features/screens/admin/client_admin/add_hour.dart';
import 'package:emptychair/features/screens/admin/client_admin/add_service.dart';
import 'package:emptychair/features/screens/admin/client_admin/client_admin_home.dart';
import 'package:emptychair/features/screens/admin/client_admin/hours.dart';
import 'package:emptychair/features/screens/admin/client_admin/services.dart';
import 'package:emptychair/features/screens/admin/dashboard.dart';
import 'package:emptychair/features/screens/admin/employee_management.dart';
import 'package:emptychair/features/screens/admin/employee_stat.dart';
import 'package:emptychair/features/screens/admin/remove_barber.dart';
import 'package:emptychair/features/screens/admin/upload_bg.dart';
import 'package:emptychair/features/screens/admin/upload_logo.dart';
import 'package:emptychair/features/screens/auth/admin_login.dart';
import 'package:emptychair/features/screens/auth/admin_started.dart';
import 'package:emptychair/features/screens/auth/client.dart';
import 'package:emptychair/features/screens/auth/forget_password.dart';
import 'package:emptychair/features/screens/client/appointment_time.dart';
import 'package:emptychair/features/screens/auth/sign_in.dart';
import 'package:emptychair/features/screens/auth/sign_in_name.dart';
import 'package:emptychair/features/screens/client/select_barber.dart';
import 'package:emptychair/features/screens/splash.dart';
import 'package:emptychair/features/screens/client/waiting_list.dart';
import 'package:get/get.dart';

class AppPages {
  static String splash = '/';
  static String signIn = '/sign_in';
  static String signInName = '/sign_in_name';
  static String selectBarber = '/select_barber';
  static String appointmentTime = '/appointment_time';
  static String waitingList = '/waiting_list';
  static String adminDashboard = '/admin_dashboard';
  static String addBarber = '/add_barber';
  static String employeeManagement = '/employee_management';
  static String removeBarber = '/remove_barber';
  static String barberDash = '/barber_dash';
  static String checkIn = '/check_in';
  static String checkList = '/check_in_list';
  static String employeeStat = '/employee_stat';
  static String changeLogo = '/change_logo';
  static String changeBg = '/change_bg';
  static String barberClockIn = '/barber_clock_in';
  static String client = '/client';
  static String adminLogin = '/admin_login';
  static String adminStarted = '/admin_started';
  static String adminOnly = '/admin_only';
  static String forgetPassword = '/forget_password';
  static String appInfo = '/app_info';
  static String clientAdmin = '/client_admin';
  static String hours = '/hours';
  static String addHour = '/add_hour';
  static String services = '/services';
  static String addService = '/add_service';
}

final appRouter = [
  GetPage(
    name: AppPages.splash,
    page: () => const SplashScreen(),
  ),
  GetPage(
    name: AppPages.signIn,
    page: () => const SignInScreen(),
  ),
  GetPage(
    name: AppPages.signInName,
    page: () => const SignInNameScreen(),
  ),
  GetPage(
    name: AppPages.selectBarber,
    page: () => const SelectBarberScreen(),
  ),
  GetPage(
    name: AppPages.appointmentTime,
    page: () => const AppointmentTimeScreen(),
  ),
  GetPage(
    name: AppPages.waitingList,
    page: () => const WaitingListScreen(),
  ),
  GetPage(
    name: AppPages.adminDashboard,
    page: () => const AdminDashboard(),
  ),
  GetPage(
    name: AppPages.addBarber,
    page: () => const AddBarberScreen(),
  ),
  GetPage(
    name: AppPages.employeeManagement,
    page: () => const EmployeeManagement(),
  ),
  GetPage(
    name: AppPages.removeBarber,
    page: () => const RemoveBarberScreen(),
  ),
  GetPage(
    name: AppPages.barberDash,
    page: () => const BarberDashboard(),
  ),
  GetPage(
    name: AppPages.checkIn,
    page: () => const CheckInBarberScreen(),
  ),
  GetPage(
    name: AppPages.checkList,
    page: () => const CheckInListScreen(),
  ),
  GetPage(
    name: AppPages.employeeStat,
    page: () => const EmployeeStatScreen(),
  ),
  GetPage(
    name: AppPages.changeLogo,
    page: () => const UpdateLogoScreen(),
  ),
  GetPage(
    name: AppPages.changeBg,
    page: () => const UpdateBGScreen(),
  ),
  GetPage(
    name: AppPages.barberClockIn,
    page: () => const ClockSelectBarberScreen(),
  ),
  GetPage(
    name: AppPages.client,
    page: () => const ClientScreen(),
  ),
  GetPage(
    name: AppPages.adminLogin,
    page: () => const AdminLoginScreen(),
  ),
  GetPage(
    name: AppPages.adminStarted,
    page: () => const AdminStarterScreen(),
  ),
  GetPage(
    name: AppPages.adminOnly,
    page: () => const AdminOnlyScreen(),
  ),
  GetPage(
    name: AppPages.forgetPassword,
    page: () => const ForgetPasswordScreen(),
  ),
  GetPage(
    name: AppPages.clientAdmin,
    page: () => const ClientAdminHome(),
  ),
  GetPage(
    name: AppPages.appInfo,
    page: () => const AppInfoScreen(),
  ),
  GetPage(
    name: AppPages.hours,
    page: () => const HourScreen(),
  ),
  GetPage(
    name: AppPages.addHour,
    page: () => const AddHourScreen(),
  ),
  GetPage(
    name: AppPages.addService,
    page: () => const AddServiceScreen(),
  ),
  GetPage(
    name: AppPages.services,
    page: () => const ServicesScreen(),
  ),
];
