import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shop/models/product.dart';
import 'package:flutter_shop/providers/products_provider.dart';
import 'package:flutter_shop/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

class ProductFormScreen extends StatefulWidget {
  static const routeName = '/product-form';
  const ProductFormScreen({Key? key}) : super(key: key);

  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  var _fomProduct = Product(
    id: null,
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
    isFavorite: false,
  );

  var _isInit = true;
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': ''
  };

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments;
      if (productId != null) {
        final product = Provider.of<ProductsProvider>(context, listen: false)
            .getProductById(productId.toString());
        _fomProduct = product;
        _initValues = {
          'title': _fomProduct.title,
          'description': _fomProduct.description,
          'price': _fomProduct.price.toString(),
          //'imageUrl': _fomProduct.imageUrl,
          'imageUrl': ''
        };
        _imageUrlController.text = _fomProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    if (_fomProduct.id != null) {
      Provider.of<ProductsProvider>(context, listen: false)
          .updateProduct(_fomProduct.id!, _fomProduct);
    } else {
      Provider.of<ProductsProvider>(context, listen: false)
          .addProduct(_fomProduct);
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Produto inserido com sucesso!'),
      behavior: SnackBarBehavior.fixed,
    ));
    Navigator.of(context).pop();
    // print(_fomProduct.id);
    // print(_fomProduct.title);
    // print(_fomProduct.description);
    // print(_fomProduct.imageUrl);
    // print(_fomProduct.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de produto'),
        actions: [IconButton(onPressed: _saveForm, icon: Icon(Icons.save))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _form,
          autovalidateMode: AutovalidateMode.always,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  initialValue: _initValues['title'],
                  decoration: InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Título não pode ser vazio';
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  onSaved: (value) {
                    _fomProduct = new Product(
                        id: _fomProduct.id,
                        title: value!,
                        description: _fomProduct.description,
                        price: _fomProduct.price,
                        imageUrl: _fomProduct.imageUrl,
                        isFavorite: _fomProduct.isFavorite);
                  },
                ),
                TextFormField(
                  initialValue: _initValues['price'],
                  decoration: InputDecoration(labelText: 'Price'),
                  //autovalidateMode: AutovalidateMode.always,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'O preço não pode estar vazio!';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Por favor, informe um número válido';
                    }
                    if (double.parse(value) <= 0) {
                      return 'O preço não pode ser menor ou igual a zero';
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  onSaved: (value) {
                    _fomProduct = new Product(
                        id: _fomProduct.id,
                        title: _fomProduct.title,
                        description: _fomProduct.description,
                        price: double.parse(value!),
                        imageUrl: _fomProduct.imageUrl,
                        isFavorite: _fomProduct.isFavorite);
                  },
                ),
                TextFormField(
                  initialValue: _initValues['description'],
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode,
                  onSaved: (value) {
                    _fomProduct = new Product(
                        id: _fomProduct.id,
                        title: _fomProduct.title,
                        description: value!,
                        price: _fomProduct.price,
                        imageUrl: _fomProduct.imageUrl,
                        isFavorite: _fomProduct.isFavorite);
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(
                        top: 8,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 10,
                          color: Colors.grey,
                        ),
                      ),
                      child: _imageUrlController.text.isEmpty
                          ? Text('Enter a URL')
                          : FittedBox(
                              child: Image.network(_imageUrlController.text),
                              fit: BoxFit.cover),
                    ),
                    Expanded(
                      child: TextFormField(
                        //initialValue: _initValues['imageUrl'],
                        decoration: InputDecoration(labelText: 'Image URL'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocusNode,
                        onEditingComplete: () {
                          setState(() {});
                        },
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                        onSaved: (value) {
                          _fomProduct = new Product(
                              id: _fomProduct.id,
                              title: _fomProduct.title,
                              description: _fomProduct.description,
                              price: _fomProduct.price,
                              imageUrl: value!,
                              isFavorite: _fomProduct.isFavorite);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      //drawer: AppDrawer(),
    );
  }
}
