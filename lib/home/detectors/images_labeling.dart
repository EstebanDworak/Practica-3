import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:practica_tres/bloc/application_bloc.dart';
import 'package:practica_tres/home/details.dart';

class ImagesLabeling extends StatefulWidget {
  ImagesLabeling({Key key}) : super(key: key);

  @override
  _ImageLabelingState createState() => _ImageLabelingState();
}

class _ImageLabelingState extends State<ImagesLabeling>
    with AutomaticKeepAliveClientMixin<ImagesLabeling> {
  ApplicationBloc _appBloc;
  bool _showShimmer = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _appBloc = BlocProvider.of<ApplicationBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    _appBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<ApplicationBloc, ApplicationState>(
      listener: (context, state) {
        if (state is LoadingState) {
          // shimmer
          _showShimmer = false;
        } else if (state is FakeDataFetchedState) {
          // shimmer
          _showShimmer = false;
        } else if (state is ErrorState) {
          // snackbar
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text("${state.message}"),
                duration: Duration(seconds: 1),
              ),
            );
        }
      },
      child: BlocBuilder<ApplicationBloc, ApplicationState>(
        builder: (context, state) {
          int _listSize = _appBloc.getLabeledItemsList.length;
          return _listSize > 0 || _showShimmer
              ? ListView.builder(
                  itemCount: _showShimmer ? 2 : _listSize,
                  itemBuilder: (BuildContext context, int index) {
                    return _showShimmer
                        ? ListTileShimmer()
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              ListTile(
                                leading: CircleAvatar(
                                  child: Icon(Icons.code),
                                  backgroundColor: Colors.amber[50],
                                ),
                                title: Text(
                                  "$index - ${_appBloc.getLabeledItemsList[index].texto}",
                                ),
                                onTap: () {
                                  // TODO: mostrar detalle
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) {
                                        return Details(
                                          imageLabeled: _appBloc
                                              .getLabeledItemsList[index],
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                              // Text(_appBloc.getLabeledItemsList[index].tituloUrl),
                              Text(
                                // _appBloc.getLabeledItemsList[index].codigo,
                                "URL: ${_appBloc.getLabeledItemsList[index].texto}",
                                style: TextStyle(
                                    color: Color.fromRGBO(180, 180, 180, 1)),
                              ),
                              Text(
                                "Tipo de código: ${_appBloc.getLabeledItemsList[index].texto}",
                                style: TextStyle(
                                    color: Color.fromRGBO(180, 180, 180, 1)),
                              )
                              ,Divider()
                            ],
                          );
                  },
                )
              : Center(child: Text("Todavia no hay objetos escaneados"));
        },
      ),
    );
  }
}
