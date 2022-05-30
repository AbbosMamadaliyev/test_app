import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/presentation/blocs/cat_fact_bloc.dart';
import 'package:test_app/presentation/history_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            child: const Text(
              'Fact history',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              context.read<CatFactBloc>().add(ShowHistoryEvent());

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HistoryPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: BlocBuilder<CatFactBloc, CatFactState>(
          builder: (BuildContext context, state) {
            if (state is CatFactInitialState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is CatFactLoadedState) {
              final date = DateTime.parse(state.catFactModel.createdAt);

              final String formatDate =
                  DateFormat('MMMM dd, yyyy').format(date);

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.catFactModel.text,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'create date: $formatDate',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: size.height * 0.3,
                      width: size.width,
                      child: Image.network(state.imgUrl),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.read<CatFactBloc>().add(
                            CatFactNextRandomEvent(),
                          ),
                      child: const Text('next random'),
                    ),
                  ],
                ),
              );
            }

            if (state is CatFactErrorState) {
              return Center(child: Text(state.message));
            }

            return const Center(child: Text('error'));
          },
        ),
      ),
    );
  }
}
