import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/cat_fact_bloc.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            context.read<CatFactBloc>().add(CatFactLoadEvent());

            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: BlocBuilder<CatFactBloc, CatFactState>(
        builder: (BuildContext context, state) {
          if (state is CatFactInitialState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ShowHistoryState) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: ListView.builder(
                  itemCount: state.history.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '$index: ${state.history[index].text}',
                        style: const TextStyle(fontSize: 24),
                      ),
                    );
                  }),
            );
          }

          return const Center(child: Text('error'));
        },
      ),
    );
  }
}
