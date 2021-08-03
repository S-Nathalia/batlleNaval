#!/usr/bin/perl
use Tk; 
use strict;
require "./back.pl";


# Criando janela principal
my $thisWindow = MainWindow->new;

my $container;
my $topBar;

#Fontes do jogo
my $font = $thisWindow->fontCreate(-size => 13, -weight => 'bold');
my $font2 = $thisWindow->fontCreate(-size => 17, -weight => 'bold');

my @btnsShips;

#Guarda o navio selecionado
my $selectShip;
my $selectAxis;

#Botão Navio
my @btn_ships;
my @btn_Axis;

#Label Navio
my @label_ships = ('Porta Aviao', 'Guerra', 'Encouracado', 'Submarino');
my @label_Axis = ('Vertical', 'Horizontal');

#Variaveis de controle do jogo
my $acc_water = 0;
my $acc_ship = 0;
my $qnt_houses = 0;
my $turn = 1;
my $acc_enemy = 0;
my $qnt_houses_enemy = 0;

#Textos do jogos
my $turn_label; 
my $pont_label; 
my $acc_label;


#Fontes do jogo
my $font = $thisWindow->fontCreate(-size => 13, -weight => 'bold');
my $font2 = $thisWindow->fontCreate(-size => 17, -weight => 'bold');

#Textos do jogos
my $turn_label; 
my $pont_label; 
my $acc_label;

#Array de btns
my @btnsPlayer;
my @btnsComputer;
my @btnsShips;



my @matrixEnemy = (
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);

my @matrixMy = (
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);


my @matrixPlays = (
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);


sub topBar{
    $topBar = $thisWindow->Frame(-relief => 'groove', -borderwidth => 3, -background => 'gray')->pack(-side => 'top', -fill =>'x');
    my $new = $topBar->Button(-text => "Jogar", -command => [\&newGame], -background => 'white', -foreground =>'black', -width => 0, -height => 1.5, -font => $font)->pack(-side => 'left');
    my $exit = $topBar->Button(-text => "Sair", -command => [\&exitGame], -background => 'white', -foreground =>'black', -width => 3, -height => 1.5, -font => $font)->pack(-side => 'right');
}

sub topBarGame{
    $topBar = $thisWindow->Frame(-relief => 'groove', -borderwidth => 3, -background => 'gray')->pack(-side => 'top', -fill =>'x');
    my $new = $topBar->Button(-text => "Criar jogo", -command => [\&createGame ], -background => 'white', -foreground =>'black', -width => 0, -height => 1.5, -font => $font)->pack(-side => 'left');
    my $exit = $topBar->Button(-text => "Sair", -command => [\&exitGame], -background => 'white', -foreground =>'black', -width => 3, -height => 1.5, -font => $font)->pack(-side => 'right');
}

sub exitGame {
    $thisWindow->destroy;
}

sub newGame {
    $thisWindow->packForget();
    startGame();
}

sub createGame { 
    $thisWindow->destroy;
    $thisWindow = MainWindow->new;
    start();
}

sub start {
    #startar tela
    $thisWindow->minsize(qw(1100 700));
    $thisWindow->title("Batalha naval");
    $thisWindow->configure(-background => "white");

    #startar barra de menu
    topBar();
    
    #startar matrix
    $container = $thisWindow->Frame(-background => "white");
    $container->pack(-side => 'top', -fill => 'x');
    
    plotMatrix(@matrixMy);

    my $subcontainer = $container->Frame(-background => "white");
    $subcontainer->pack(-side => 'top', -fill => 'x');

    my $label1 = $subcontainer->Label(-text => "Selecione o tipo de navio:", -background => 'white', -width => 25, -height => 1.5, -font => $font)->pack();
    
    my $midle   = $subcontainer->Frame(-background => "white")->pack(-side => 'left', -pady => 1, -padx => 125);
    for(my $i = 0; $i < 4; $i++){
        my $aux = @label_ships[$i];
        $btn_ships[$i] = $midle->Button(-text => "$aux", -width => 10, -height => 3, -background => "white");
        $btn_ships[$i]->configure(-command => [\&selectShip,  $i+1]);
        $btn_ships[$i]->pack(-side => 'left', -padx => 10);
    }
 
    my $subcontainer1 = $container->Frame(-background => "white");
    $subcontainer1->pack(-side => 'top', -fill => 'x');

    my $label1 = $subcontainer1->Label(-text => "Selecione a orientacao:", -background => 'white', -width => 25, -height => 1.5, -font => $font)->pack();
    

    my $midle1   = $subcontainer1->Frame(-background => "white")->pack(-side => 'left', -pady => 1, -padx => 240);
    
    for(my $i = 0; $i < 2; $i++){
        my $aux = @label_Axis[$i];
        $btn_Axis[$i] = $midle1->Button(-text => "$aux", -width => 10, -height => 3, -background => "white");
        $btn_Axis[$i]->configure(-command => [\&selectAxis,  $i]);
        $btn_Axis[$i]->pack(-side => 'left', -pady => 11, -padx => 10);
    }
    
    MainLoop();
}

sub selectShip {
    $selectShip = @_[0];
    for(my $i = 0; $i < 4; $i++){
        $btn_ships[$i]->configure(-background => "white");
    }
    $btn_ships[$selectShip - 1]->configure(-background => "gray");
}

sub selectAxis {
    $selectAxis = @_[0];
        for(my $i = 0; $i < 2; $i++){
        $btn_Axis[$i]->configure(-background => "white");
    }
    $btn_Axis[$selectAxis]->configure(-background => "gray");
}

sub plotMatrixGame  {
    #Receber Matriz e parametros
    my @end = @{$_[0]};
    my $param = $_[1];
    
    #plotando matriz
    for(my $i = 0; $i <= $#end; $i++){

        #Criar Frame
        my $left = $container->Frame(-background => "white");
        $left->pack(-side => 'left', -pady => 1, -padx => 1);
        for(my $j = 0; $j <= $#end ; $j++){             
            if($param ne 'blocked'){
                $btnsPlayer[$i][$j] = $left->Button(-text => "0", -width => 3, -height => 3, -background => "white");
                $btnsPlayer[$i][$j]->configure(-command => [\&clickJogar, $j, $i, $btnsPlayer[$i][$j]]);
                $btnsPlayer[$i][$j]->pack();  
                if($end[$i][$j] != 0){
                    $qnt_houses = $qnt_houses + 1;
                }
            }else{
                $btnsComputer[$i][$j] = $left->Button(-text => "0", -width => 3, -height => 3, -background => "white");
                $btnsComputer[$i][$j]->pack(); 
                if($end[$i][$j] != 0){
                    $qnt_houses_enemy = $qnt_houses_enemy + 1;
                }
                $btnsComputer[$i][$j]->configure(-state => 'disabled');   
            }
        }   
    }   
}

sub enemyTurn {

    $turn = $turn + 1;
    $turn_label->configure(-text => "Turno $turn: turno do inimigo!", -foreground => 'red'); 

    #funcao que retorna a posicao (i, j) de onde o computador vai jogar(COMUNICACAO COM BACK)
    
    my $i   =   0; 
    my $j   =   0; 
    
    ($i, $j) = playsComputer();
    #funcão que retorna value da posicao da matriz (i, j) (COMUNICACAO COM BACK) PRONTOOOOOOOOOOOo
    my $value = enemyPlay($i, $j);
    print($i, $j);
    
    if($value == 0){
        #atualizar matriz inimiga
        $btnsComputer[$i][$j]->configure(-text=>"9");
        #turno do jogador
        $turn = $turn + 1;
        $turn_label->configure(-text => "Turno $turn: Seu turno!", -foreground => 'green');  
        able();  
    }
    else{
        $acc_enemy = $acc_enemy + 1; 
        #atualizar matriz inimiga
        $btnsComputer[$i][$j]->configure(-text=>"8");    
        if($acc_enemy == $qnt_houses_enemy){
            lost();
        }else{
           enemyTurn();   
        }
    }
}

sub won {
    my $response = $thisWindow->messageBox(-message => 'Voce Venceu!', -title => 'Vencedor', -type => 'AbortRetryIgnore', -default => 'Retry');
}

sub lost {
    my $response = $thisWindow->messageBox(-icon => 'error', -message => 'Voce perdeu :(', -title => 'Perdedor', -type => 'AbortRetryIgnore', -default => 'Retry');
}

sub clickJogar {
    #receber parametros
    disable();
    my @clicked=@_;
    
    #funcão que retorna value da posicao da matriz (COMUNICACAO COM BACK) PRONTOOOOOOO
    #return {
    #  tipo de barco no ponto(i, j)
    #}
    
    my $value = plays($clicked[1], $clicked[0]);
    

    my $i = $clicked[1];
    my $j = $clicked[0];

    if($value == 0){
        $acc_water = $acc_water + 1;
        #atualizar matriz
        $clicked[2]->configure(-text=>"9");

        $matrixPlays[$i][$j] = 1;

        $acc_label->configure(-text => "Acertos agua: $acc_water");
        enemyTurn();
    }
    else{
        $acc_ship = $acc_ship + 1; 
        #atualizar matriz
        $clicked[2]->configure(-text=>"8");
        $matrixPlays[$i][$j] = 1;

        $pont_label->configure(-text => "Sua pontuacao eh: $acc_ship/$qnt_houses");
        if($acc_ship == $qnt_houses){
            won();
        }else{
            $turn = $turn + 1;
            $turn_label->configure(-text => "Turno $turn: Seu turno!", -foreground => 'green');
            able();
        }
    }
}

sub startGame{
    #startar tela
    $thisWindow->destroy;
    $thisWindow = MainWindow->new;

    $thisWindow->minsize(qw(1100 700));
    $thisWindow->title("Batalha naval");
    $thisWindow->configure(-background => "white");

    #startar barra de menu
    topBarGame();
    
    #start pontuacoes
    $container = $thisWindow->Frame(-background => "white");
    $container->pack(-side => 'top', -fill => 'x');

    my $points = $container->Frame(-background => "white");
    $points->pack(-side => 'top', -fill => 'x');
    
    my $left1       = $points->Frame(-background => 'white')->pack(-side => 'left', -padx => 0);
    $pont_label     = $left1->Label(-text => "Sua pontuacao eh: $acc_ship/$qnt_houses", -background => 'white', -width => 25, -height => 1.5, -font => $font, -anchor => 'w')->pack();
    $acc_label      = $left1->Label(-text => "Acertos agua: $acc_water", -background => 'white', -width => 25, -height => 1.5, -font => $font, -anchor => 'w')->pack();
    $turn_label     = $left1->Label(-text => "Turno $turn: Seu turno!", -background => 'white', -width => 25, -height => 1.5, -font => $font, -foreground => 'green', -anchor => 'w')->pack();
    
    #startar matrix
    my $name    = $container->Frame(-background => "white");
    $name->pack(-side => 'top', -fill => 'x');
    my $label_3 = $name->Label(-text => "Campo Inimigo", -background => 'white', -width => 12, -height => 1.5, -font => $font2)->pack(-side => 'left', -padx => 167);
    my $label_4 = $name->Label(-text => "Seu Campo", -background => 'white', -width => 12, -height => 1.5, -font => $font2)->pack(-side => 'right', -padx => 165);

    @matrixEnemy = addShipsComputer();     
    

    for(my $i = 0 ; $i< 10; $i++){
    for(my $j = 0; $j< 10; $j++){
        print "$matrixEnemy[$i][$j]";
    }
    print "\n";
    }

    plotMatrixGame(\@matrixEnemy, 'unblocked');
    $pont_label->configure(-text => "Sua pontuacao eh: $acc_ship/$qnt_houses");
    my $midle   = $container->Frame(-background => "white")->pack(-side => 'left', -pady => 1, -padx => 20);

    

    plotMatrixGame(\@matrixMy, 'blocked');
    
    MainLoop();
}

sub plotMatrix  {
    #Receber Matriz e parametros
    my @end = @_;
    
    #plotando matriz
    for(my $i = 0; $i <= $#end; $i++){

        #Criar Frame
        my $left = $container->Frame(-background => "white");
        $left->pack(-side => 'left', -pady => 1, -padx => 1);
        for(my $j = 0; $j <= $#end ; $j++){             
            $btnsShips[$i][$j] = $left->Button(-text => "0", -width => 3, -height => 3, -background => "white");
            $btnsShips[$i][$j]->configure(-command => [\&click, $j, $i, $btnsShips[$i][$j]]);
            $btnsShips[$i][$j]->pack();  
        }   
    }   
}

sub click {
    my @clicked=@_;
    #funcao que retorna a minha matriz validada (COMUNICACAO COM BACK) PRONTOOOOOOOOOOOOOO
    #return {
    #  [True e matriz] or [False e Mensagem]
    #}
    my $return;
    my @array; 

    ($return, @array) = &addShips($selectShip, $clicked[1], $clicked[0], $selectAxis, 0);

    if($return == 0){
        @matrixMy = @array;
        for(my $i = 0; $i < 10; $i++){
            for(my $j = 0; $j < 10; $j++){
                $btnsShips[$i][$j]->configure(-text=>"$array[$i][$j]");


                if($array[$i][$j] != 0){
                    $btnsShips[$i][$j]->configure(-state => 'disabled');
                }
            }
        }
    }else{
        my $response = $thisWindow->messageBox(-icon => 'error', -message => 'Nao eh possivel adicionar navio', -title => 'Error', -type => 'AbortRetryIgnore', -default => 'Retry');
    } 
}

sub disable {
    for(my $i = 0; $i < 10; $i++){
        for(my $j = 0; $j < 10 ; $j++){             
            $btnsPlayer[$i][$j]->configure(-state => 'disabled');  
        }   
    }
}

sub able {
    for(my $i = 0; $i < 10; $i++){
        for(my $j = 0; $j < 10 ; $j++){                  
            if($matrixPlays[$i][$j] == 1){
                $btnsPlayer[$i][$j]->configure(-state => 'disabled');  
            }else{
                $btnsPlayer[$i][$j]->configure(-state => 'normal'); 
            }    
        }   
    }
}

start();

