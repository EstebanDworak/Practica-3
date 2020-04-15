import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:practica_tres/bloc/application_bloc.dart';

class ImagesLabeling extends StatefulWidget {
  ImagesLabeling({Key key}) : super(key: key);

  @override
  _ImagesLabelingState createState() => _ImagesLabelingState();
}

class _ImagesLabelingState extends State<ImagesLabeling> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ApplicationBloc, ApplicationState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: BlocBuilder<ApplicationBloc, ApplicationState>(
        builder: (context, state) {
          // TODO: hacer vista similar a la de barcode
          return ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return ListTileShimmer();
            },
          );
        },
      ),
    );
  }
}
