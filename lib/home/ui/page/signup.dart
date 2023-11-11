import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:server_api/server_api.dart';
import 'package:organisation_api/organisation_api.dart';
import 'package:trust_app/home/ui/view/view.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key, this.host, this.port, this.protocol});

  final String? host;
  final int? port;
  final String? protocol;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    ActiveServerCubit activeServer = context.read<ActiveServerCubit>();

    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
              create: (
                  context) => TypeOrganisationRepository(
                  protocol: activeServer.state.protocol, host: activeServer.state.host, port: activeServer.state.port
              )
          ),
          RepositoryProvider(
              create: (
                  context) => CountryRepository(
                  protocol: activeServer.state.protocol, host: activeServer.state.host, port: activeServer.state.port
              )
          ),
          RepositoryProvider(
              create: (
                  context) => OrganisationRepository(
                  protocol: activeServer.state.protocol, host: activeServer.state.host, port: activeServer.state.port
              )
          )
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => CountryApiStatusCubit()),
              BlocProvider(create: (context) => SelectedCountryCubit()),
              BlocProvider(
                  create: (context) => CountryMenuCubit(
                      countryRepository: context.read<CountryRepository>(),
                      connectivityStatus: context.read<ConnectivityStatusCubit>(),
                      apiStatus: context.read<CountryApiStatusCubit>()
                  )..getAll()
              ),
              BlocProvider(create: (context) => TypeOrganisationApiStatusCubit()),
              BlocProvider(create: (context) => SelectedTypeOrganisationCubit()),
              BlocProvider(
                  create: (context) => TypeOrganisationMenuCubit(
                      typeOrganisationRepository: context.read<TypeOrganisationRepository>(),
                      connectivityStatus: context.read<ConnectivityStatusCubit>(),
                      apiStatus: context.read<TypeOrganisationApiStatusCubit>()
                  )..getAll()
              ),
              BlocProvider(create: (context) => OrganisationApiStatusCubit()),
              BlocProvider(create: (context) => SignupLoadingCubit()),
              BlocProvider(
                  create: (context) => OrganisationCubit(
                      organisationRepository: context.read<OrganisationRepository>(),
                      connectivityStatus: context.read<ConnectivityStatusCubit>(),
                      apiStatus: context.read<OrganisationApiStatusCubit>(),
                  )
              ),
              BlocProvider(create: (context) => SetupOrganisationCubit()),
            ],
            child: Scaffold(
                backgroundColor: Colors.white60.withOpacity(0.4),
                body: Center(
                  child: SizedBox.fromSize(
                    size: Size(width * 0.60, height * 0.90),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.white,
                      ),
                      child: CustomScrollView(
                        slivers: [
                          SliverAppBar(
                            pinned: true,
                            floating: true,
                            title: const Text('Nouvelle Organisation'),
                            centerTitle: true,
                            titleTextStyle: const TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.w500),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          const SliverToBoxAdapter(
                            child: SignUpForm(),
                          )
                        ],
                      ),
                    ),
                  ),
                )
            )
        )
    );
  }
}
