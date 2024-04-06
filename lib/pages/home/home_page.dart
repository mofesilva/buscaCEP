import 'dart:ui';

import 'package:busca_cep/models/cep_model.dart';
import 'package:busca_cep/widgets/c_filled_button.dart';
import 'package:busca_cep/widgets/info_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _cepController = TextEditingController();
  Endereco endereco = Endereco();
  Endereco? _selectedEndereco;
  bool _isLoading = false;
  bool _gotEndereco = false;
  bool _showError = false;
  RegExp cepValidator = RegExp(r'^[0-9]{5}[-][0-9]{3}$');

  Future _getEndereco() async {
    // TESTE NOVAMENTE
    if (cepValidator.hasMatch(_cepController.text)) {
      debugPrint('CEP Validated and has matched');
      setState(() {
        _isLoading = true;
        _showError = false;
      });

      _selectedEndereco = await endereco.fetch(_cepController.text);

      if (_selectedEndereco != null) {
        setState(() {
          _isLoading = false;
          _gotEndereco = true;
        });
        return _selectedEndereco;
      } else {
        setState(() {
          _showError = true;
        });
      }
    } else {
      debugPrint('CEP Validated and has not matched');
      setState(() {
        _showError = true;
      });
    }
  }

  void _returnToMainPage() {
    setState(() {
      _gotEndereco = false;
      _selectedEndereco = null;
      endereco = Endereco();
    });
  }

  List<Widget> get _buscaCepForm => [
        Text(
          'Busca CEP',
          style: GoogleFonts.rajdhani(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        _showError
            ? Padding(
                padding: const EdgeInsets.only(bottom: 12, top: 12),
                child: Text(
                  'CEP informado é inválido. Favor conferir e tentar novamente',
                  style: GoogleFonts.rajdhani(
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                  ),
                ),
              )
            : const SizedBox(),
        Padding(
          padding: const EdgeInsets.only(bottom: 12, top: 12),
          child: Container(
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
            ),
            decoration: BoxDecoration(
                color: const Color(0xffe8e2d2),
                borderRadius: BorderRadius.circular(15)),
            child: TextField(
              style: GoogleFonts.rajdhani(fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  labelText: 'Digite o cep',
                  labelStyle: GoogleFonts.rajdhani(fontWeight: FontWeight.w500),
                  floatingLabelBehavior: FloatingLabelBehavior.auto),
              controller: _cepController,
            ),
          ),
        ),
        CFilledButton(
          isLoading: _isLoading,
          buttonLabel: 'BUSCAR',
          onPressed: _getEndereco,
        )
      ];

  List<Widget> get _showEndereco => [
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xffe8e2d2)),
          child: Column(
            children: [
              InfoListTile(
                icon: Icons.numbers,
                title: 'CEP',
                subtitle: _selectedEndereco!.cep,
              ),
              InfoListTile(
                icon: Icons.abc_rounded,
                title: 'Logradouro',
                subtitle: _selectedEndereco!.logradouro,
              ),
              InfoListTile(
                icon: Icons.pin_drop_rounded,
                title: 'Bairro',
                subtitle: _selectedEndereco!.bairro,
              ),
              InfoListTile(
                icon: Icons.map_rounded,
                title: 'UF',
                subtitle: _selectedEndereco!.uf,
              ),
              InfoListTile(
                icon: Icons.phone_enabled_rounded,
                title: 'DDD',
                subtitle: _selectedEndereco!.ddd,
              ),
            ],
          ),
        ),
        FilledButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              const Color(0xffc1a792),
            ),
            textStyle: MaterialStateProperty.all(
              GoogleFonts.rajdhani(fontWeight: FontWeight.w500),
            ),
          ),
          onPressed: _returnToMainPage,
          child: _isLoading
              ? const CircularProgressIndicator()
              : const Text('BUSCAR NOVO CEP'),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xfffcfbfc),
        body: Center(
          child: AspectRatio(
            aspectRatio:
                MediaQuery.of(context).size.height > 720 ? 3 / 4 : 4 / 3,
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: _gotEndereco ? _showEndereco : _buscaCepForm,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
