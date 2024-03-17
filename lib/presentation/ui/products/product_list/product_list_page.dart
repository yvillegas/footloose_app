import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footloose_app/domain/models/brand.dart';
import 'package:footloose_app/domain/models/color.dart';
import 'package:footloose_app/domain/models/model.dart';
import 'package:footloose_app/domain/models/product.dart';
import 'package:footloose_app/domain/models/size.dart';
import 'package:footloose_app/domain/use_cases/get_brands.dart';
import 'package:footloose_app/domain/use_cases/get_colors.dart';
import 'package:footloose_app/domain/use_cases/get_models.dart';
import 'package:footloose_app/domain/use_cases/get_products.dart';
import 'package:footloose_app/domain/use_cases/get_sizes.dart';
import 'package:footloose_app/injection/injection.dart';
import 'package:footloose_app/presentation/blocs/brand_bloc/brand_bloc.dart';
import 'package:footloose_app/presentation/blocs/color_bloc/color_bloc.dart';
import 'package:footloose_app/presentation/blocs/model_bloc/model_bloc.dart';
import 'package:footloose_app/presentation/blocs/product_list/product_list_bloc.dart';
import 'package:footloose_app/presentation/blocs/size_bloc/size_bloc.dart';
import 'package:footloose_app/presentation/routes/app_routes.dart';
import 'package:footloose_app/presentation/ui/products/product_detail/product_detail_page.dart';
import 'package:footloose_app/presentation/ui/products/product_list/widgets/empty_products.dart';
import 'package:footloose_app/presentation/ui/products/product_list/widgets/failure_products.dart';
import 'package:footloose_app/presentation/ui/products/product_list/widgets/product_list_item.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductListBloc(
            getProducts: getIt<GetProducts>(),
          ),
        ),
        BlocProvider(
          create: (context) => BrandBloc(
            getBrands: getIt<GetBrands>(),
          ),
        ),
        BlocProvider(
          create: (context) => ModelBloc(
            getModels: getIt<GetModels>(),
          ),
        ),
        BlocProvider(
          create: (context) => SizeBloc(
            getSizes: getIt<GetSizes>(),
          ),
        ),
        BlocProvider(
          create: (context) => ColorBloc(
            getColors: getIt<GetColors>(),
          ),
        ),
      ],
      child: const ProductList(),
    );
  }
}

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late ProductListBloc _productListBloc;
  late BrandBloc _brandBloc;
  late ModelBloc _modelBloc;
  late ColorBloc _colorBloc;
  late SizeBloc _sizeBloc;

  // Brand
  var _brands = <Brand>[];
  Brand? _selectedBrand;

  // Model
  var _models = <Model>[];
  Model? _selectedModel;

  // Sizes
  var _sizes = <Size>[];
  Size? _selectedSize;

  // Color
  var _colors = <Color>[];
  Color? _selectedColor;

  // Products
  var _products = <Product>[];
  var _filteredProducts = <Product>[];

  RangeValues _rangePrices = const RangeValues(0, 1000);

  @override
  void initState() {
    super.initState();
    _productListBloc = context.read<ProductListBloc>();
    _brandBloc = context.read<BrandBloc>();
    _modelBloc = context.read<ModelBloc>();
    _colorBloc = context.read<ColorBloc>();
    _sizeBloc = context.read<SizeBloc>();

    _productListBloc.add(const OnGetProducts());
    _brandBloc.add(const OnGetBrands());
    _modelBloc.add(const OnGetModels());
    _colorBloc.add(const OnGetColors());
    _sizeBloc.add(const OnGetSizes());
  }

  void _showBrands() {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            _brands.length,
            (index) => ListTile(
              title: Text(_brands[index].nombreMarca),
              onTap: () {
                _selectedBrand = _brands[index];
                _filterProducts();
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }

  void _showModels() {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            _models.length,
            (index) => ListTile(
              title: Text(_models[index].nombreModelo),
              onTap: () {
                _selectedModel = _models[index];
                _filterProducts();
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }

  void _showColors() {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            _colors.length,
            (index) => ListTile(
              title: Text(_colors[index].nombreColor),
              onTap: () {
                _selectedColor = _colors[index];
                _filterProducts();
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }

  void _showSizes() {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            _sizes.length,
            (index) => ListTile(
              title: Text(_sizes[index].nombreTalla),
              onTap: () {
                _selectedSize = _sizes[index];
                _filterProducts();
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }

  void _filterProducts() {
    setState(() {
      _filteredProducts = _products;
      if (_selectedBrand != null) {
        _filteredProducts = _filteredProducts
            .where((product) => product.idMarca == _selectedBrand!.idMarca)
            .toList();
      }
      if (_selectedModel != null) {
        _filteredProducts = _filteredProducts
            .where((product) => product.idModelo == _selectedModel!.idModelo)
            .toList();
      }
      if (_selectedColor != null) {
        _filteredProducts = _filteredProducts
            .where((product) => product.idColor == _selectedColor!.idColor)
            .toList();
      }
      if (_selectedSize != null) {
        _filteredProducts = _filteredProducts
            .where((product) => product.idTalla == _selectedSize!.idTalla)
            .toList();
      }
      _filteredProducts = _filteredProducts
          .where(
            (product) =>
                _rangePrices.start.round() <= product.precioProducto &&
                product.precioProducto <= _rangePrices.end.round(),
          )
          .toList();
    });
  }

  Widget _filterSection() {
    if (_selectedBrand == null &&
        _selectedModel == null &&
        _selectedSize == null &&
        _selectedColor == null) {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filtros seleccionados',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                if (_selectedBrand != null)
                  Chip(
                    label: Text(_selectedBrand!.nombreMarca),
                    onDeleted: () {
                      setState(() {
                        _selectedBrand = null;
                        _filterProducts();
                      });
                    },
                  ),
                if (_selectedModel != null)
                  Chip(
                    label: Text(_selectedModel!.nombreModelo),
                    onDeleted: () {
                      setState(() {
                        _selectedModel = null;
                        _filterProducts();
                      });
                    },
                  ),
                if (_selectedColor != null)
                  Chip(
                    label: Text(_selectedColor!.nombreColor),
                    onDeleted: () {
                      setState(() {
                        _selectedColor = null;
                        _filterProducts();
                      });
                    },
                  ),
                if (_selectedSize != null)
                  Chip(
                    label: Text(_selectedSize!.nombreTalla),
                    onDeleted: () {
                      setState(() {
                        _selectedSize = null;
                        _filterProducts();
                      });
                    },
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _priceRangeFilter() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rango de Precio S/(${_rangePrices.start.round()} - ${_rangePrices.end.round()}) ',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            children: [
              const Text('S/0'),
              Expanded(
                child: RangeSlider(
                  values: _rangePrices,
                  max: 1000,
                  divisions: 1000,
                  labels: RangeLabels(
                    _rangePrices.start.round().toString(),
                    _rangePrices.end.round().toString(),
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _rangePrices = values;
                      _filterProducts();
                    });
                  },
                ),
              ),
              const Text('S/1000'),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == 'Marca') {
                _showBrands();
              }
              if (value == 'Modelo') {
                _showModels();
              }
              if (value == 'Color') {
                _showColors();
              }
              if (value == 'Talla') {
                _showSizes();
              }
            },
            itemBuilder: (BuildContext context) {
              return const [
                PopupMenuItem(
                  value: 'Modelo',
                  child: Text('Modelo'),
                ),
                PopupMenuItem(
                  value: 'Marca',
                  child: Text('Marca'),
                ),
                PopupMenuItem(
                  value: 'Color',
                  child: Text('Color'),
                ),
                PopupMenuItem(
                  value: 'Talla',
                  child: Text('Talla'),
                ),
                PopupMenuItem(
                  value: 'Precio',
                  child: Text('Precio'),
                )
              ];
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.qr_code),
        onPressed: () async {
          final productoId = await Navigator.push(
            context,
            MaterialPageRoute<int>(
              builder: (context) => const QRContainer(),
            ),
          );
          if (productoId != null) {
            unawaited(
              Navigator.pushNamed(
                context,
                AppRoutes.productDetail,
                arguments: ProductDetailPageArguments(
                  productoId: productoId,
                ),
              ),
            );
          }
        },
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<BrandBloc, BrandState>(
            listener: (context, state) {
              if (state is SuccessGetBrands) {
                _brands = state.brands;
              }
            },
          ),
          BlocListener<ModelBloc, ModelState>(
            listener: (context, state) {
              if (state is SuccessGetModels) {
                _models = state.models;
              }
            },
          ),
          BlocListener<ColorBloc, ColorState>(
            listener: (context, state) {
              if (state is SuccessGetColors) {
                _colors = state.colors;
              }
            },
          ),
          BlocListener<SizeBloc, SizeState>(
            listener: (context, state) {
              if (state is SuccessGetSizes) {
                _sizes = state.sizes;
              }
            },
          ),
          BlocListener<ProductListBloc, ProductListState>(
            listener: (context, state) {
              if (state is SuccessGetProducts) {
                _products = state.products;
                _filteredProducts = state.products;
              }
            },
          ),
        ],
        child: BlocBuilder<ProductListBloc, ProductListState>(
          builder: (context, state) {
            if (state is LoadingGetProducts) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SuccessGetProducts) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    _filterSection(),
                    _priceRangeFilter(),
                    if (_filteredProducts.isEmpty)
                      const EmptyProducts()
                    else
                      Column(
                        children: List.generate(
                          _filteredProducts.length,
                          (index) => ProductListItem(
                            product: _filteredProducts[index],
                          ),
                        ),
                      ),
                    const SizedBox(height: 50),
                  ],
                ),
              );
            }
            return FailureProducts(
              onPressed: () {
                _productListBloc.add(const OnGetProducts());
              },
            );
          },
        ),
      ),
    );
  }
}

class QRContainer extends StatefulWidget {
  const QRContainer({super.key});

  @override
  State<QRContainer> createState() => _QRContainerState();
}

class _QRContainerState extends State<QRContainer> {
  QRViewController? _controller;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _controller = controller;
      _controller?.scannedDataStream.listen((scanData) {
        final body = json.decode(scanData.code ?? '') as Map<String, dynamic>;
        Navigator.pop(context, body['idProducto']);
        _controller?.dispose();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return QRView(
      key: _qrKey,
      onQRViewCreated: _onQRViewCreated,
    );
  }
}
