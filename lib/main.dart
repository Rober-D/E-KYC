import 'package:e_kyc/core/routes/routes.dart';
import 'package:e_kyc/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:e_kyc/features/auth/presentation/pages/login_page.dart';
import 'package:e_kyc/features/auth/presentation/provider/user_token_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_kyc/injection_container.dart' as di;
import 'package:provider/provider.dart';
import 'features/national_id/presentation/bloc/national_id_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthBloc>()),
        BlocProvider(create: (_) => di.sl<NationalIdBloc>()),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserTokenProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: Routes.generateRoute,
          home: LoginPage(),
        ),
      )
    );
  }
}