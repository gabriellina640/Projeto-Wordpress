# 🧱 Projeto WordPress com Docker

Este repositório contém uma estrutura completa para rodar uma loja virtual WordPress + WooCommerce usando Docker, com suporte a plugins essenciais para performance, segurança, SEO, pagamentos, frete e mais.

---

## 🚀 Tecnologias Utilizadas

- Docker
- Docker Compose
- WordPress 6+
- WooCommerce 10+
- MySQL
- Traefik (proxy reverso)
- DuckDNS + HTTPS com SSL (futuramente)

---

## 📦 Plugins Incluídos

| Plugin                                       | Função                                       |
|---------------------------------------------|----------------------------------------------|
| WooCommerce                                  | Loja virtual                                 |
| WooCommerce Correios                         | Cálculo de frete pelos Correios              |
| WooCommerce Payments                         | Pagamentos (Pix, Cartão, etc)                |
| Elementor                                    | Construtor visual                            |
| AddToAny                                     | Botões de compartilhamento                   |
| MailPoet                                     | Newsletter e e-mails automáticos             |
| PDF Invoices & Packing Slips                 | Faturas em PDF                               |
| Wordfence                                    | Segurança avançada                           |
| WP Super Cache                               | Cache para performance                       |
| Yoast SEO                                    | Otimização para motores de busca             |
| Advanced Shipment Tracking                   | Rastreamento de pedidos                      |

---

## 🛠 Como Rodar Localmente

1. **Clone o repositório:**

```bash
git clone https://github.com/gabriellina640/Projeto-Wordpress.git
cd Projeto-Wordpress

    Inicie os containers:

docker compose up -d

    Acesse no navegador:

http://localhost

    Use o Docker Desktop no Windows ou docker engine no Linux. Certifique-se de que as portas 80/443 não estejam em uso.

🧳 Como Migrar para Outro Computador

    Clone o repositório no novo PC.

    Instale Docker e Docker Compose.

    Rode docker compose up -d.

    (Opcional) Restaure o backup do banco de dados, caso necessário.

✅ Próximas Etapas

Customização do visual do site

Criação de produtos e categorias

Ativação de certificados SSL com Traefik + DuckDNS

Integração com gateway de pagamento real

    Testes em produção

👨‍💻 Desenvolvido por

Gabriel Henrique - @gabriellina640
📄 Licença

Este projeto está licenciado sob a MIT License.


---

### ✅ O que fazer agora?

1. Salve esse conteúdo em um arquivo chamado `README.md` na raiz do seu projeto.
2. No terminal:

```bash
git add README.md
git commit -m "Adiciona README.md profissional"
git push
