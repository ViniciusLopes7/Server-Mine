# Tutorial Completo - Minecraft Server 1.21.11
## Adrenaline + Chunky + QoL + Tailscale

---

## 📚 ÍNDICE

1. [O que cada componente faz](#1-o-que-cada-componente-faz)
2. [Instalação Passo a Passo](#2-instalação-passo-a-passo)
3. [Como Conectar no Linux](#3-como-conectar-no-linux)
4. [Primeiros Passos Após Instalação](#4-primeiros-passos-após-instalação)
5. [Comandos do Servidor](#5-comandos-do-servidor)
6. [Segurança e Manutenção](#6-segurança-e-manutenção)
7. [Otimização de BIOS e Hardware](#7-otimização-de-bios-e-hardware-importante)
8. [Otimizações Avançadas do Linux](#8-otimizações-avançadas-do-linux)
9. [Dicas de Hardware](#9-dicas-de-hardware)
10. [Monitoramento Avançado](#10-monitoramento-avançado)

---

## 1. O que cada componente faz

### 1.1 Sistema Operacional - Arch Linux Minimal

**O que é:** Uma distribuição Linux leve e minimalista.

**Por que usar:**
- Consome poucos recursos (ideal para 4GB RAM)
- Sem programas desnecessários rodando em segundo plano
- Mais RAM disponível para o Minecraft
- Atualizações rápidas e sistema estável

**Analogy:** É como ter um carro de corrida sem ar-condicionado, rádio ou bancos de couro - só o essencial para ir rápido!

---

### 1.2 Java 21 (OpenJDK)

**O que é:** A máquina virtual que executa o Minecraft.

**Por que Java 21:**
- Minecraft 1.21.11 requer Java 21
- Melhor performance que versões antigas
- Otimizações de memória mais eficientes

**Como funciona:** O Minecraft é escrito em Java, então precisa do Java instalado para rodar. É como o .NET Framework para programas Windows.

---

### 1.3 Adrenaline Modpack

**O que é:** Um pacote de mods focado exclusivamente em performance.

**Mods incluídos:**

| Mod | O que faz | Benefício |
|-----|-----------|-----------|
| **Lithium** | Otimiza a lógica do jogo | Reduz uso de CPU em 20-40% |
| **FerriteCore** | Reduz uso de memória | Economiza 30-50% de RAM |
| **ModernFix** | Otimizações diversas | Carregamento mais rápido |
| **C2ME** | Otimiza chunks | Geração de mundo mais rápida |
| **Krypton** | Otimiza rede | Menos lag para jogadores |
| **Spark** | Profiler integrado | Diagnostica problemas de performance |

**Analogy:** É como fazer um "tune-up" no motor do carro - o mesmo carro, mas muito mais eficiente!

---

### 1.4 Chunky

**O que é:** Ferramenta de pré-geração de chunks do mundo.

**Por que usar:**
- Gera chunks ANTES dos jogadores chegarem
- Elimina "lag de geração" quando jogadores exploram
- Reduz quedas de TPS (Ticks Por Segundo)

**Como funciona:**
1. Você define uma área (ex: 1000 blocos de raio)
2. Chunky gera todos os chunks dessa área
3. Quando jogadores exploram, o mundo já está gerado
4. Resultado: Zero lag de geração!

**Quando usar:**
- ANTES de abrir o servidor para jogadores
- Após expandir o mundo
- Quando mudar de versão do Minecraft

**Analogy:** É como preparar a comida ANTES dos convidados chegarem - quando chegam, tudo está pronto!

---

### 1.5 Essential Commands

**O que é:** Adiciona comandos essenciais de qualidade de vida.

**Comandos disponíveis:**

| Comando | O que faz | Exemplo |
|---------|-----------|---------|
| `/home` | Teletransporta para sua home | `/home` |
| `/sethome` | Define uma home | `/sethome base` |
| `/delhome` | Deleta uma home | `/delhome base` |
| `/spawn` | Vai para o spawn do servidor | `/spawn` |
| `/tpa` | Pede para teleportar até alguém | `/tpa Steve` |
| `/tpahere` | Pede para alguém vir até você | `/tpahere Steve` |
| `/tpaccept` | Aceita pedido de teleporte | `/tpaccept` |
| `/tpadeny` | Recusa pedido de teleporte | `/tpadeny` |
| `/back` | Volta ao local anterior | `/back` |
| `/rtp` | Teletransporte aleatório | `/rtp` |
| `/nick` | Define um apelido | `/nick ProPlayer` |

**Configuração padrão:**
- Máximo de 3 homes por jogador
- Teleporte gratuito (sem custo de XP)
- Funciona entre dimensões (Overworld/Nether/End)

---

### 1.6 Universal Graves

**O que é:** Sistema de túmulos quando jogadores morrem.

**Como funciona:**
1. Jogador morre
2. Um túmulo é criado no local da morte
3. Todos os itens e XP são guardados no túmulo
4. Jogador recebe coordenadas do túmulo
5. Jogador tem 5 minutos de proteção para recuperar itens

**Benefícios:**
- Itens não caem no chão (evita despawn)
- Outros jogadores não podem roubar (durante proteção)
- Holograma mostra localização
- Interface GUI para recuperar itens

**Analogy:** É como um "cofre temporário" que aparece quando você morre!

---

### 1.7 TabTPS

**O que é:** Mostra informações de performance na lista de jogadores (TAB).

**O que aparece:**
- **TPS** (Ticks Por Segundo): Quanto maior, melhor (20 = perfeito)
- **MSPT** (Milissegundos Por Tick): Quanto menor, melhor
- **Uso de memória**: RAM usada pelo servidor

**Como interpretar TPS:**
| TPS | Significado |
|-----|-------------|
| 20.0 | Perfeito |
| 19.0-19.9 | Excelente |
| 15.0-18.9 | Bom |
| 10.0-14.9 | Lag perceptível |
| < 10.0 | Muito lag |

**Analogy:** É como o velocímetro do carro - mostra se o servidor está indo bem ou precisa de ajuda!

---

### 1.8 Styled Chat

**O que é:** Personaliza a aparência do chat do servidor.

**Recursos:**
- Formatação com cores
- Placeholders dinâmicos (%player%, %tps%, etc.)
- Mensagens de entrada/saída personalizadas
- Mensagens de morte estilizadas

**Exemplo de chat:**
```
[20.0] Steve » Olá pessoal!
+ Alex entrou no servidor
- Steve saiu do servidor
☠ Steve foi morto por Zumbi
```

---

### 1.9 Tailscale

**O que é:** Uma VPN (Rede Privada Virtual) mesh.

**Como funciona:**
1. Cria uma rede privada entre seus dispositivos
2. Cada dispositivo recebe um IP fixo na rede Tailscale
3. Conexão criptografada e segura
4. Funciona através de NATs e firewalls

**Vantagens para Minecraft:**
- **Não precisa abrir portas no roteador!**
- Conexão criptografada (mais segura)
- IP fixo (não muda quando reinicia)
- Acesso de qualquer lugar
- Compartilhe o IP com amigos facilmente

**Analogy:** É como ter uma "estrada privada" entre seu PC e o servidor, sem precisar abrir a estrada principal para todo mundo!

---

### 1.10 Screen

**O que é:** Permite rodar programas em "background".

**Por que usar:**
- Servidor continua rodando mesmo se você desconectar do SSH
- Pode acessar o console do servidor a qualquer momento
- Múltiplas "janelas" no mesmo terminal

**Comandos:**
```bash
screen -r minecraft    # Acessar console
Ctrl+A, depois D       # Sair sem parar o servidor
```

---

### 1.11 Systemd

**O que é:** Sistema de inicialização do Linux.

**Por que usar:**
- Inicia servidor automaticamente na boot
- Reinicia servidor se travar
- Gerenciamento fácil (start, stop, restart)
- Logs organizados

---

## 2. Instalação Passo a Passo

### 2.1 Preparação

```bash
# 1. Baixe todos os arquivos do pacote
mkdir ~/minecraft-setup
cd ~/minecraft-setup

# 2. Liste os arquivos (devem estar todos aqui)
ls -la
# Deve mostrar: install.sh, start-server.sh, mc-manager.sh, etc.

  # 3. Dê permissão de execução aos scripts
  chmod +x *.sh
  ```

  ### 2.2 Executar Instalador

  ```bash
  # Execute como root
  sudo ./install.sh
1. Atualiza o sistema
2. Instala Java 21, Screen, e ferramentas
3. Cria usuário "minecraft"
4. Instala Adrenaline Modpack
5. Baixa mods de QoL (Chunky, Essential Commands, etc.)
6. Instala Tailscale
7. Configura server.properties
8. Configura mods
9. Cria serviço systemd
10. Cria atalhos de comandos

**Tempo estimado:** 5-10 minutos (depende da internet)

### 2.3 Após Instalação

```bash
# 1. Conectar Tailscale
sudo tailscale up

# Siga as instruções na tela:
# - Abra o link no navegador
# - Faça login com Google/Microsoft/GitHub
# - Autorize o dispositivo

# 2. Ver IP do Tailscale
sudo tailscale ip -4
# Anote este IP! É o endereço do seu servidor.

# 3. Iniciar servidor
sudo systemctl start minecraft

# 4. Verificar se iniciou
sudo systemctl status minecraft
```

---

## 3. Como Conectar no Linux

### 3.1 Método 1: Tailscale (Recomendado)

**No servidor:**
```bash
# Ver IP do Tailscale
sudo tailscale ip -4
# Exemplo: 100.x.x.x
```

**No seu PC Linux:**

```bash
# 1. Instalar Tailscale
# Ubuntu/Debian:
curl -fsSL https://tailscale.com/install.sh | sh

# Arch:
sudo pacman -S tailscale

# Fedora:
sudo dnf install tailscale

# 2. Iniciar Tailscale
sudo systemctl enable --now tailscaled

# 3. Conectar à mesma conta
sudo tailscale up

# 4. Verificar conexão
sudo tailscale status
# Deve mostrar o servidor na lista
```

**No Minecraft:**
1. Abra o Minecraft
2. Clique em "Multiplayer"
3. Clique em "Add Server"
4. Server Name: Meu Servidor
5. Server Address: `100.x.x.x:25565` (IP do Tailscale)
6. Clique em "Done"
7. Clique no servidor e "Join Server"

### 3.2 Método 2: IP Local (mesma rede)

Se PC e servidor estão na mesma rede WiFi/cabo:

```bash
# No servidor, descubra o IP local
ip addr show | grep "inet " | head -1
# Exemplo: 192.168.1.50
```

No Minecraft, use: `192.168.1.50:25565`

### 3.3 Método 3: IP Público (com port forwarding)

⚠️ **Atenção:** Menos seguro! Use Tailscale se possível.

```bash
# Descubra seu IP público
curl ifconfig.me
# Exemplo: 203.0.113.45
```

**Configurar roteador:**
1. Acesse 192.168.1.1 (geralmente)
2. Login: admin / senha do roteador
3. Procure "Port Forwarding" ou "Virtual Servers"
4. Adicione:
   - Porta externa: 25565
   - Porta interna: 25565
   - IP interno: IP do servidor (ex: 192.168.1.50)
   - Protocolo: TCP

No Minecraft, use: `203.0.113.45:25565`

---

## 4. Primeiros Passos Após Instalação

### 4.1 Executar Pré-Geração (Chunky)

**Por que fazer:** Elimina lag quando jogadores exploram.

**Quando fazer:** Antes de abrir para jogadores.

```bash
# 1. Acessar console
/opt/minecraft-server/mc-manager.sh console

# 2. Configurar área (exemplo: 1000 blocos de raio)
/chunky radius 1000
/chunky center 0 0

# 3. Iniciar pré-geração
/chunky start

# 4. Acompanhar progresso
/chunky status

# 5. Quando terminar, saia do console
# Pressione Ctrl+A, depois D
```

**Tempo estimado:**
- 500 blocos: ~30 minutos
- 1000 blocos: ~2 horas
- 2000 blocos: ~8 horas

**Dica:** Faça durante a noite! O servidor pode ficar lento durante a geração.

### 4.2 Configurar Backup Automático

```bash
sudo /opt/minecraft-server/setup-cron.sh

# Escolha opção 1 (diário às 3h) - Recomendado
```

### 4.3 Carregar Atalhos

```bash
# Adicione ao ~/.bashrc para carregar automaticamente
echo "source /opt/minecraft-server/comandos.sh" >> ~/.bashrc

# Ou carregue manualmente
source /opt/minecraft-server/comandos.sh

  # Agora você pode usar todos estes atalhos rápidos:
  mcstart      # Iniciar o servidor em segundo plano (systemd)
  mcstop       # Parar o servidor com segurança (avisa os players e salva o mundo)
  mcrestart    # Reiniciar o servidor
  mcstatus     # Ver status completo do serviço
  mclogs       # Ver logs do console pelo systemd (Ctrl+C para sair)
  mcconsole    # Acessar console interativo (Ctrl+A depois D para sair)
  mcinfo       # Exibir uso de CPU/RAM e PID
  mcbackup     # Fazer backup do mundo
  mcchunky     # Menu interativo para pré-gerar mundo
  mctps        # Checar o TPS do servidor sem precisar entrar
  mctailscale  # Ver status da conexão Tailscale
mcconsole

# No console do Minecraft:
op SeuNick

# Saia do console (Ctrl+A, D)
```

---

## 5. Comandos do Servidor

### 5.1 Comandos Básicos do Minecraft

```
/op <jogador>              - Dar operador
/deop <jogador>            - Remover operador
/whitelist add <jogador>   - Adicionar à whitelist
/whitelist remove <jogador>- Remover da whitelist
/ban <jogador>             - Banir jogador
/kick <jogador>            - Expulsar jogador
/save-all                  - Salvar mundo
/stop                      - Parar servidor
/gamemode <modo> <jogador> - Mudar modo de jogo
/tp <jogador1> <jogador2>  - Teletransportar
/give <jogador> <item>     - Dar item
/time set day              - Mudar para dia
/weather clear             - Limpar clima
```

### 5.2 Comandos de QoL (Essential Commands)

```
/home                      - Ir para home
/sethome <nome>            - Definir home
/delhome <nome>            - Deletar home
/spawn                     - Ir para spawn
/tpa <jogador>             - Pedir teleporte
/tpaccept                  - Aceitar teleporte
/tpadeny                   - Recusar teleporte
/back                      - Voltar ao local anterior
/rtp                       - Teletransporte aleatório
/nick <apelido>            - Definir apelido
```

### 5.3 Comandos do Chunky

```
/chunky start              - Iniciar pré-geração
/chunky pause              - Pausar
/chunky continue           - Continuar
/chunky cancel             - Cancelar
/chunky status             - Ver progresso
/chunky radius <blocos>    - Definir raio
/chunky center <x> <z>     - Definir centro
/chunky world <mundo>      - Selecionar mundo
```

### 5.4 Comandos do Spark (Profiler)

```
/spark health              - Ver saúde do servidor
/spark tps                 - Ver TPS
/spark gc                  - Ver estatísticas de GC
/spark profiler            - Iniciar profiler
```

---

## 6. Segurança e Manutenção

### 6.1 Segurança Básica

```bash
# 1. Manter sistema atualizado
sudo pacman -Syu

# 2. Verificar logs de acesso
sudo tailscale status

# 3. Ver quem está conectado no Minecraft
mcconsole
list
Ctrl+A, D
```

### 6.2 Backup Manual

```bash
# Fazer backup agora
mcbackup

# Ou
/opt/minecraft-server/mc-manager.sh backup
```

### 6.3 Restaurar Backup

```bash
# 1. Parar servidor
mcstop

# 2. Navegar até backups
cd /opt/minecraft-server/backups

# 3. Listar backups
ls -la

# 4. Extrair backup
sudo tar -xzf backup-20250115-030000.tar.gz -C /opt/minecraft-server/

# 5. Ajustar permissões
sudo chown -R minecraft:minecraft /opt/minecraft-server/world*

# 6. Iniciar servidor
mcstart
```

### 6.4 Atualizar Modpack

```bash
# Faz backup e atualiza
/opt/minecraft-server/mc-manager.sh update
```

### 6.5 Monitoramento

```bash
# Ver recursos do sistema
htop

# Ver I/O do disco
sudo iotop

# Ver logs do servidor
mclogs

# Ver status detalhado
mcinfo
```

---

## 7. Otimização de BIOS e Hardware (IMPORTANTE!)

Esta seção é **fundamental** para extrair o máximo desempenho do seu i3-6006U. Mesmo sem poder fazer overclock (o i3-6006U é travado em 2.0GHz), existem várias configurações de BIOS que fazem diferença significativa.

### 7.1 Como Acessar a BIOS

A tecla varia por fabricante de notebook:

| Fabricante | Tecla |
|------------|-------|
| **Dell** | F2 ou F12 |
| **HP** | F10 ou Esc |
| **Lenovo** | F2 ou Fn+F2 |
| **Acer** | F2 ou Del |
| **ASUS** | F2 ou Del |
| **Samsung** | F2 |
| **Positivo/Outros** | F2 ou Del |

**Como acessar:** Desligue o notebook completamente. Ligue e pressione a tecla repetidamente **antes** do logo aparecer.

---

### 7.2 Configurações de BIOS para Performance

#### ⚡ SATA Mode → AHCI (Prioridade MÁXIMA)

**O que é:** Define como o disco (HDD/SSD) se comunica com o processador.

**Onde encontrar:** `Advanced` → `SATA Configuration` → `SATA Mode`

**Configurar:** Selecione **AHCI** (não IDE)

**Por que:** AHCI permite que o disco use NCQ (Native Command Queuing), que reordena operações de I/O para serem mais eficientes. Em um HDD, isso pode melhorar a performance de leitura/escrita em **15-30%**.

⚠️ **ATENÇÃO:** Se o SO já foi instalado em modo IDE, mudar para AHCI pode impedir o boot. Nesse caso, será necessário reinstalar ou reconfigurar o kernel antes.

```
✅ AHCI = Performance máxima de I/O
❌ IDE = Compatibilidade antiga, mais lento
```

---

#### ⚡ Hyper-Threading → HABILITADO

**O que é:** Permite que cada núcleo do i3-6006U processe 2 threads simultâneas.

**Onde encontrar:** `Advanced` → `CPU Configuration` → `Hyper-Threading Technology`

**Configurar:** **Enabled** (habilitado)

**Por que:** O i3-6006U tem 2 núcleos físicos. Com Hyper-Threading ligado, ele expõe 4 threads ao sistema. O Minecraft usa 1-2 threads principais, mas o sistema operacional, Tailscale, backups e outros processos usam as threads extras. **Manter habilitado é essencial** com apenas 2 núcleos.

```
✅ HT Ligado = 2 núcleos + 4 threads (melhor multitarefa)
❌ HT Desligado = 2 núcleos + 2 threads (SO compete com Minecraft)
```

---

#### ⚡ C-States → DESABILITAR ou Limitar (C1 apenas)

**O que é:** Estados de economia de energia do processador. Quando o CPU está "ocioso", ele entra em estados progressivamente mais profundos (C1, C3, C6, C7...) para economizar energia.

**Onde encontrar:** `Advanced` → `CPU Configuration` → `CPU C-States` ou `C State Support`

**Configurar:**
- **Opção ideal:** Desabilitar completamente os C-States
- **Opção alternativa:** Limitar ao C1 (se a BIOS permitir)

**Por que:** Quando o CPU sai de um estado profundo (C6/C7), ele leva **milissegundos** para voltar à performance máxima. Em um servidor Minecraft, isso causa **micro-stutters** (engasgos) porque o servidor precisa responder a cada tick (50ms). Cada milissegundo perdido saindo de C-States é lag perceptível.

**Trade-off:** Desabilitar C-States aumenta o consumo de energia em ~3-5W e a temperatura em ~5-10°C. Em um notebook plugado na tomada rodando servidor 24/7, isso é aceitável.

```
✅ C-States Desabilitadas = Latência mínima, sem micro-stutters
⚠️ C1 Only = Bom compromisso (economia leve, pouca latência)
❌ Todas habilitadas = Economia máxima, mas lag periódico
```

---

#### ⚡ Intel SpeedStep (EIST) → DESABILITAR

**O que é:** Tecnologia que reduz dinamicamente a frequência do CPU quando ele não está sob carga pesada.

**Onde encontrar:** `Advanced` → `CPU Configuration` → `Intel SpeedStep` ou `EIST`

**Configurar:** **Disabled** (desabilitado)

**Por que:** O i3-6006U roda a 2.0GHz fixo (não tem Turbo Boost). Com SpeedStep habilitado, ele pode cair para **400MHz-800MHz** quando "acha" que não precisa de mais. O problema é que o Minecraft tem picos repentinos de carga (explosão de TNT, geração de chunks), e a transição de 800MHz → 2.0GHz adiciona latência.

**Trade-off:** Desabilitando, o CPU sempre estará em 2.0GHz. Aumenta consumo por ~2-3W, mas garante resposta instantânea.

```
✅ SpeedStep Desabilitado = 2.0GHz constante, resposta instantânea
❌ SpeedStep Habilitado = Pode cair para 800MHz, delays ao voltar
```

---

#### ⚡ Secure Boot → DESABILITAR

**O que é:** Recurso que verifica assinaturas digitais durante o boot.

**Onde encontrar:** `Security` → `Secure Boot` ou `Boot` → `Secure Boot Control`

**Configurar:** **Disabled**

**Por que:**
- Arch Linux Minimal funciona melhor sem Secure Boot
- Evita problemas com módulos de kernel customizados
- Remove uma etapa do processo de boot (boot ~1-2s mais rápido)

---

#### ⚡ Boot Mode → UEFI

**O que é:** Define o modo de inicialização do sistema.

**Onde encontrar:** `Boot` → `Boot Mode` ou `Boot` → `UEFI/Legacy`

**Configurar:** **UEFI Only**

**Por que:** UEFI é mais rápido que Legacy/BIOS tradicional. Boot ~3-5 segundos mais rápido.

---

#### ⚡ Periféricos Não Usados → DESABILITAR

Desabilite o que **não está usando** para liberar recursos:

| Periférico | Onde encontrar | Quando desabilitar |
|------------|----------------|--------------------|
| **Wi-Fi integrado** | Advanced → Wireless | Se usar cabo ethernet (recomendado para servidores!) |
| **Bluetooth** | Advanced → Bluetooth | Sempre (servidor não precisa) |
| **Webcam** | Advanced → Camera | Sempre (servidor headless) |
| **Leitor de cartão** | Advanced → Card Reader | Sempre |
| **Áudio integrado** | Advanced → Audio | Se não usar (servidor headless) |

**Por que:** Cada periférico ativo consome um pouco de CPU e memória para manter drivers e interrupções. Desabilitar libera recursos para o Minecraft.

**Dica:** Ethernet (cabo) é **muito** mais estável que Wi-Fi para um servidor. Se possível, conecte o notebook com cabo ethernet e desabilite o Wi-Fi na BIOS.

---

### 7.3 Resumo das Configurações de BIOS

| Configuração | Valor Recomendado | Impacto |
|-------------|-------------------|---------|
| SATA Mode | **AHCI** | ⭐⭐⭐⭐⭐ Crítico |
| Hyper-Threading | **Enabled** | ⭐⭐⭐⭐⭐ Crítico |
| C-States | **Disabled** | ⭐⭐⭐⭐ Alto |
| Intel SpeedStep | **Disabled** | ⭐⭐⭐⭐ Alto |
| Secure Boot | **Disabled** | ⭐⭐⭐ Médio |
| Boot Mode | **UEFI** | ⭐⭐ Baixo |
| Wi-Fi (se usar cabo) | **Disabled** | ⭐⭐ Baixo |
| Bluetooth | **Disabled** | ⭐ Baixo |

---

## 8. Otimizações Avançadas do Linux

Estas otimizações complementam as do BIOS e extraem ainda mais do hardware.

### 8.1 CPU Governor → Performance

**O que é:** O Linux tem seu próprio controle de frequência do CPU (independente do BIOS).

**Analogia:** Mesmo desabilitando o SpeedStep na BIOS, o Linux pode tentar gerenciar a frequência por conta própria. Precisamos dizer ao Linux para SEMPRE usar performance máxima.

```bash
# 1. Instalar cpupower
sudo pacman -S cpupower

# 2. Definir governor para "performance"
sudo cpupower frequency-set -g performance

# 3. Verificar se aplicou
cpupower frequency-info
# Deve mostrar: "performance" como governor ativo

# 4. Tornar permanente (sobrevive reboot)
sudo systemctl enable cpupower
```

**Configurar o serviço cpupower para boot:**
```bash
# Editar configuração
sudo nano /etc/default/cpupower

# Alterar a linha:
# governor='ondemand'
# Para:
governor='performance'
```

**Por que:** O governor "ondemand" (padrão) demora para escalar a frequência quando o Minecraft precisa de mais CPU. Com "performance", o CPU está sempre pronto.

---

### 8.2 Parâmetros de Kernel (GRUB)

Adicionar parâmetros ao kernel que otimizam o comportamento do CPU:

```bash
# 1. Editar configuração do GRUB
sudo nano /etc/default/grub

# 2. Encontrar a linha GRUB_CMDLINE_LINUX_DEFAULT e adicionar:
GRUB_CMDLINE_LINUX_DEFAULT="quiet intel_idle.max_cstate=1 processor.max_cstate=1 idle=halt"
```

**Explicação de cada parâmetro:**

| Parâmetro | O que faz | Benefício |
|-----------|-----------|-----------|
| `intel_idle.max_cstate=1` | Limita C-States no nível do SO (reforço do BIOS) | Reduz latência |
| `processor.max_cstate=1` | Limita C-States no driver ACPI | Redundância de segurança |
| `idle=halt` | Usa HLT ao invés de MWAIT quando ocioso | Menor latência ao sair de idle |

```bash
# 3. Aplicar mudanças
sudo grub-mkconfig -o /boot/grub/grub.cfg

# 4. Reiniciar
sudo reboot
```

**Verificar após reboot:**
```bash
# Verificar se os parâmetros foram aplicados
cat /proc/cmdline
# Deve mostrar os parâmetros adicionados
```

---

### 8.3 ZRAM — Swap Comprimido na RAM (ESSENCIAL com 4GB!)

**O que é:** ZRAM cria um dispositivo de swap **na própria RAM**, usando compressão. Ao invés de usar o HDD lento como swap, os dados são comprimidos e mantidos na RAM.

**Por que é essencial:**
- Com **4GB de RAM total**, o sistema PRECISA de swap
- Swap em **HDD** é extremamente lento (~100 MB/s vs ~1000 MB/s com zram)
- ZRAM comprime ~2:1, então 1GB de ZRAM equivale a ~2GB de swap
- **Resultado:** Você ganha efetivamente ~2GB de "RAM virtual" com velocidade aceitável

**Analogia:** É como comprimir suas roupas a vácuo para caber mais no armário, ao invés de guardar as extras no porão (HDD).

```bash
# 1. Instalar zram-generator (método moderno no Arch)
sudo pacman -S zram-generator

# 2. Criar configuração
sudo tee /etc/systemd/zram-generator.conf << 'EOF'
[zram0]
# Tamanho do ZRAM (recomendado: mesma quantidade da RAM ou menos)
zram-size = min(ram, 4096)

# Algoritmo de compressão (zstd é o melhor custo-benefício)
compression-algorithm = zstd

# Prioridade do swap (maior = usado primeiro, antes do HDD)
swap-priority = 100

# Número máximo de streams de compressão (usar número de threads)
fs-type = swap
EOF

# 3. Recarregar systemd e reiniciar
sudo systemctl daemon-reload
sudo systemctl start systemd-zram-setup@zram0.service

# 4. Verificar se está funcionando
zramctl
# Deve mostrar algo como:
# NAME       ALGORITHM DISKSIZE DATA COMPR TOTAL STREAMS MOUNTPOINT
# /dev/zram0 zstd         3.8G   0B   0B    0B       4 [SWAP]

# 5. Verificar swap
swapon --show
# Deve mostrar /dev/zram0 como swap ativo

# 6. Desabilitar swap em arquivo (se existir)
# Se tiver swap em HDD, desabilite para usar apenas ZRAM:
sudo swapoff /dev/sdXX  # substitua pelo dispositivo de swap
# Remova ou comente a linha de swap no /etc/fstab
```

**Configuração do swappiness com ZRAM:**
```bash
# Com ZRAM, podemos aumentar o swappiness (ao contrário do swap em HDD)
# Isso porque ZRAM é rápido (está na RAM!)

# Alterar de 10 (que configuramos antes para HDD) para 180
# Sim, 180! Com ZRAM, valores altos são recomendados
echo "vm.swappiness=180" | sudo tee /etc/sysctl.d/99-zram.conf
sudo sysctl -p /etc/sysctl.d/99-zram.conf
```

**⚠️ IMPORTANTE:** Se você configurou `vm.swappiness=10` antes (para HDD), agora com ZRAM deve mudar para `180`. Edite `/etc/sysctl.conf` e remova a linha antiga, ou adicione o novo valor em `/etc/sysctl.d/99-zram.conf` (que tem prioridade).

---

### 8.4 Remover e Desabilitar Pacotes Inúteis (Arch Minimal)

Como o Arch Linux atuará exclusivamente como um servidor **"headless"** (sem interface gráfica) e conectado via **cabo de rede (RJ45)**, podemos remover completamente subsistemas pesados como Áudio, Bluetooth e Wi-Fi para liberar a máxima RAM possível.

Verifique e remova os seguintes pacotes:

```bash
# 1. Parar serviços ativos (para evitar erros na remoção)
sudo systemctl disable --now bluetooth.service 2>/dev/null
sudo systemctl disable --now iwd.service 2>/dev/null
sudo systemctl disable --now wpa_supplicant.service 2>/dev/null
systemctl --user mask pipewire wireplumber pulseaudio 2>/dev/null

# 2. Desinstalar completamente usando pacman (remove dependências não usadas com -Rns)
# Remover Bluetooth
sudo pacman -Rns bluez bluez-utils

# Remover servidores de Áudio
sudo pacman -Rns pipewire pipewire-pulse pipewire-alsa pipewire-jack wireplumber pulseaudio

# Remover Wi-Fi (já que vai usar RJ45 ethernet)
sudo pacman -Rns wpa_supplicant iwd dialog

# 3. Limpar cache do pacman para recuperar espaço no disco
sudo pacman -Scc
```

**NÃO desabilite:**
- `NetworkManager` ou `systemd-networkd` (rede)
- `tailscaled` (VPN)
- `sshd` (acesso remoto)
- `systemd-timesyncd` (sincronização de hora)

---

### 8.5 Otimização de I/O para HDD

Além do scheduler BFQ (já configurado no install.sh), adicione:

```bash
# 1. Aumentar read-ahead do HDD (melhora leitura sequencial)
echo 4096 | sudo tee /sys/block/sda/queue/read_ahead_kb

# 2. Tornar permanente
sudo tee /etc/udev/rules.d/61-hdd-readahead.rules << 'EOF'
ACTION=="add|change", KERNEL=="sda", ATTR{queue/read_ahead_kb}="4096"
EOF

# 3. Habilitar TRIM periódico (se usar SSD no futuro)
sudo systemctl enable fstrim.timer
```

**Por que 4096KB de read-ahead?**
O HDD lê dados sequencialmente muito mais rápido do que aleatoriamente. Aumentar o read-ahead faz o kernel "prever" que vai precisar dos próximos blocos e lê-los antecipadamente. Para Minecraft (que lê muitos chunks sequenciais), isso ajuda significativamente.

---

## 9. Dicas de Hardware

### 9.1 🏆 Upgrade Mais Impactante: SSD

Se puder fazer **apenas uma** melhoria no hardware, troque o **HDD por um SSD SATA**.

| Aspecto | HDD | SSD SATA |
|---------|-----|----------|
| Leitura sequencial | ~100 MB/s | ~550 MB/s |
| Leitura aleatória | ~0.5 MB/s | ~50 MB/s |
| Tempo de boot | 30-60s | 10-15s |
| Carregamento de chunks | Lento | Instantâneo |
| Preço (240GB) | - | ~R$100-150 |

**O i3-6006U tem interface SATA III** (6Gbps), então qualquer SSD SATA funciona.

**Impacto no Minecraft:**
- Boot do servidor: **30-60s → 10-15s**
- Carregamento de chunks: **2-5x mais rápido**
- Backups: **3-4x mais rápidos**
- TPS durante exploração: **significativamente mais estável**

**SSDs baratos recomendados:**
- Kingston A400 240GB
- WD Green 240GB
- Crucial BX500 240GB

> Você não precisa de um SSD grande. 240GB é suficiente para o SO + servidor Minecraft.

---

### 9.2 🌡️ Gerenciamento Térmico do Notebook

O i3-6006U é um processador de notebook com TDP de 15W. Quando esquenta demais, ele faz **throttling** (reduz frequência automaticamente para esfriar), causando lag.

**Dicas essenciais:**

1. **Limpar a ventoinha e as saídas de ar**
   - Notebooks acumulam pó com o tempo
   - Com o notebook desligado, use ar comprimido nas saídas de ar
   - Se possível, abra e limpe a ventoinha internamente

2. **Trocar a pasta térmica** (a cada 2-3 anos)
   - Pasta térmica seca = CPU ~10-15°C mais quente
   - Pasta térmica nova (Arctic MX-4 ou similar): ~R$15-30
   - Reduz temperatura em ~10-15°C

3. **Posicionar o notebook corretamente**
   - **NUNCA** coloque em cima de cama, almofada ou superfície que bloqueie a ventilação
   - Use uma **mesa plana** ou um **suporte com ventilação**
   - Elevar a traseira em ~2-3cm já melhora o fluxo de ar

4. **Cooler pad (opcional)**
   - R$30-60 no mercado
   - Reduz temperatura em ~5-8°C
   - Vale muito a pena para uso 24/7

**Monitorar temperatura:**
```bash
# Instalar lm_sensors
sudo pacman -S lm_sensors

# Detectar sensores
sudo sensors-detect
# Responda "yes" para todas as perguntas

# Ver temperaturas
sensors
# Deve mostrar algo como:
# coretemp-isa-0000
#   Core 0:       +55.0°C
#   Core 1:       +53.0°C
```

**Temperaturas aceitáveis para i3-6006U:**

| Temperatura | Status |
|------------|--------|
| < 60°C | ✅ Excelente |
| 60-75°C | ⚠️ Normal sob carga |
| 75-85°C | ⚠️ Quente, melhorar ventilação |
| > 85°C | ❌ Throttling! Limpar/trocar pasta |

---

### 9.3 🔌 Notebook Sempre na Tomada

Como o notebook será usado como servidor 24/7:

1. **Mantenha sempre plugado** — a bateria não será usada
2. **Se a BIOS tiver a opção**, configure para limitar a carga da bateria em 60-80% (Dell e Lenovo têm essa opção)
3. **Considere remover a bateria** se for removível — evita degradação e reduz calor

---

## 10. Monitoramento Avançado

### 10.1 Monitorar I/O do Disco (HDD)

O HDD é o gargalo principal do servidor. Monitore-o:

```bash
# Instalar ferramentas
sudo pacman -S sysstat

# Ver I/O em tempo real
iostat -xz 2
# Observe a coluna "%util" — se estiver > 80% constantemente,
# o HDD está no limite e um SSD resolveria

# Ver I/O por processo
sudo iotop -oP
# Mostra qual processo está usando mais disco
```

**Interpretar iostat:**
| Coluna | Significado | Valor ideal |
|--------|-------------|-------------|
| `r/s` | Leituras por segundo | < 100 |
| `w/s` | Escritas por segundo | < 50 |
| `%util` | Utilização do disco | < 70% |
| `await` | Tempo médio de espera (ms) | < 20ms |

---

### 10.2 Monitorar CPU

```bash
# Ver uso de CPU por núcleo
mpstat -P ALL 2

# Ver processos que mais usam CPU
top -H -p $(pgrep -f "java.*server.jar")
# Mostra as threads Java individualmente
```

---

### 10.3 Alertas de Temperatura Automáticos

```bash
# Criar script de monitoramento
sudo tee /opt/minecraft-server/monitor-temp.sh << 'SCRIPT'
#!/bin/bash
# Monitora temperatura e avisa jogadores se estiver alta

TEMP=$(sensors | grep "Core 0" | awk '{print $3}' | tr -d '+°C' | cut -d. -f1)

if [ "$TEMP" -gt 85 ]; then
    # Temperatura crítica - avisar jogadores
    if screen -list | grep -q minecraft; then
        screen -S minecraft -p 0 -X stuff "say §c[ALERTA] §eCPU em ${TEMP}°C! Possível lag por throttling.\\n"
    fi
    echo "[$(date)] ALERTA: CPU em ${TEMP}°C" >> /opt/minecraft-server/monitor.log
fi
SCRIPT

chmod +x /opt/minecraft-server/monitor-temp.sh

# Adicionar ao cron (verificar a cada 5 minutos)
(sudo crontab -l 2>/dev/null; echo "*/5 * * * * /opt/minecraft-server/monitor-temp.sh") | sudo crontab -
```

---

### 10.4 Script de Relatório Completo

```bash
# Criar script de relatório
sudo tee /opt/minecraft-server/relatorio.sh << 'SCRIPT'
#!/bin/bash
echo "=========================================="
echo "  RELATÓRIO DO SERVIDOR - $(date)"
echo "=========================================="
echo ""

echo "--- CPU ---"
echo "Governor: $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)"
echo "Frequência: $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq | awk '{printf "%.0f MHz", $1/1000}')"
echo "Temperatura: $(sensors 2>/dev/null | grep "Core 0" | awk '{print $3}')"
echo "Load: $(uptime | awk -F'load average:' '{print $2}')"
echo ""

echo "--- MEMÓRIA ---"
free -h
echo ""

echo "--- SWAP/ZRAM ---"
swapon --show
zramctl 2>/dev/null
echo ""

echo "--- DISCO ---"
df -h /opt/minecraft-server
iostat /dev/sda 1 1 2>/dev/null | tail -2
echo ""

echo "--- SERVIDOR MINECRAFT ---"
if screen -list | grep -q minecraft; then
    PID=$(pgrep -f "java.*server.jar" | head -1)
    echo "Status: RODANDO (PID: $PID)"
    echo "RAM: $(ps -p $PID -o rss= 2>/dev/null | awk '{printf "%.1f MB", $1/1024}')"
    echo "CPU: $(ps -p $PID -o %cpu= 2>/dev/null)%"
    echo "Uptime: $(ps -p $PID -o etime= 2>/dev/null)"
else
    echo "Status: PARADO"
fi
echo ""

echo "--- TAILSCALE ---"
sudo tailscale status 2>/dev/null | head -5
echo ""
echo "=========================================="
SCRIPT

chmod +x /opt/minecraft-server/relatorio.sh
```

**Uso:**
```bash
sudo /opt/minecraft-server/relatorio.sh
```

---

## 🎯 Checklist Final

Antes de abrir para jogadores:

- [ ] Instalação concluída com sucesso
- [ ] Tailscale conectado e funcionando
- [ ] Pré-geração (Chunky) executada
- [ ] Backup automático configurado
- [ ] Atalhos carregados no ~/.bashrc
- [ ] Operadores configurados (/op)
- [ ] Whitelist ativada (se desejado)
- [ ] Teste de conexão realizado
- [ ] IP do Tailscale anotado/compartilhado

---

## 📞 Suporte

**Problemas comuns:**

1. **Servidor não inicia**
   - Verifique logs: `sudo journalctl -u minecraft -n 50`
   - Verifique RAM disponível: `free -h`

2. **Não consegue conectar**
   - Verifique Tailscale: `sudo tailscale status`
   - Verifique firewall: `sudo iptables -L | grep 25565`

3. **Lag excessivo**
   - Verifique TPS: `mctps`
   - Reduza view-distance no server.properties
   - Verifique uso de recursos: `htop`

---

**Documentação completa:** `minecraft-server-setup.md`
