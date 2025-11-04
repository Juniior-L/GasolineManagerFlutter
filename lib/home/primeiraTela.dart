import 'package:atividade_prova/widgets/drawer.dart';
import 'package:flutter/material.dart';

class PrimeiraTela extends StatefulWidget {
  const PrimeiraTela({super.key});

  @override
  State<PrimeiraTela> createState() => _PrimeiraTelaState();
}

class _PrimeiraTelaState extends State<PrimeiraTela> {
  // final _controller = ProdutoController();

  late Future<List> _produtosFuture;

  @override
  // void initState() {
  //   super.initState();
  //   _carregarProdutos();
  // }

  // void _carregarProdutos() {
  //   setState(() {
  //     _produtosFuture = _controller.listarProdutos();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Produtos')),
      drawer: MeuDrawer(),
      body: FutureBuilder<List>(
        future: _produtosFuture,
        builder: (context, snapshot) {
          // Enquanto carrega
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Se deu erro
          if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar produtos: ${snapshot.error}'),
            );
          }

          final produtos = snapshot.data ?? [];

          // Se não há produtos
          if (produtos.isEmpty) {
            return const Center(child: Text('Nenhum produto cadastrado.'));
          }

          // Lista de produtos
          return ListView.builder(
            itemCount: produtos.length,
            itemBuilder: (context, index) {
              final produto = produtos[index];
              final nome = produto.nome ?? 'Produto ${index + 1}';
              final preco = produto.preco?.toStringAsFixed(2) ?? '0.00';

              return ListTile(
                title: Text(nome),
                subtitle: Text('Preço: R\$ $preco'),
                // trailing: IconButton(
                //   icon: const Icon(Icons.delete, color: Colors.red),
                //   onPressed: () async {
                //     await _controller.removerProduto(produto.id);
                //     _carregarProdutos(); // atualiza a lista após exclusão
                //   },
                // ),
              );
            },
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     // navega para a tela de cadastro
      //     await Navigator.pushNamed(context, '/segunda');
      //     _carregarProdutos(); // recarrega ao voltar
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}