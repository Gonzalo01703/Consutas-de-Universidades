#!"c:\xampp\perl\bin\perl.exe"
use strict;
use warnings;
use CGI;


print "Content-type: text/html\n\n";
print <<HTML;
<!DOCTYPE html>
<html>
<head>
    
    <link rel="stylesheet" type="text/css" href="../estilo2.css">
    <title>buscando</title>
</head>
<body>
    <div >
HTML

my $q = CGI->new;
my $busqueda= $q->param("busqueda");
my $indicador = $q->param("indicador");
my $flag;
my $contador=0;
my $encontrados=0;

    $busqueda = uc $busqueda;
    print "USTED INGRESO: ".$busqueda;

    if($indicador eq "Nombre De Universidad"){
        &busqueda(1);
    } 
    elsif($indicador eq "Periodo De Licenciamiento"){
        &busqueda(4);
    }elsif($indicador eq "Departamento Local"){
        &busqueda(10);
    }elsif($indicador eq "Denominacion De Programa"){
        &busqueda(16);
    }else{
        print "ERROR";
    }

if(!defined($flag)){
    print "<h1>No encontrado</h1>\n";
}

print <<HTML;
 Ingrese <a href="../index.html">aqui</a> para regresar al formulario de búsqueda
 </body>
</html>
HTML

sub busqueda{
    my ($numCasillero)=@_;
    open(IN,"../licenciadas.csv") or die "<h1>ERROR: open file</h1>\n";
        while(my $line = <IN>){
            my @palabras= split("/",$line);
    
            if($contador==0){
                print <<HTML;
                <div class="forma">
HTML
                foreach my $element (@palabras){
                    
                    print <<HTML;
                    <div>
HTML
                    print $element;
                    print <<HTML;
                    </div>
HTML
                }
                print <<HTML;
                    </div>
HTML
                $contador++;
            }
            if($palabras[$numCasillero]=~ /$busqueda/){
                 print <<HTML;
                <div class="forma">
HTML

                foreach my $element (@palabras){
                    print <<HTML;
                    <div>
HTML
                    print $element;
                    print <<HTML;
                    </div>
HTML
                }
                print <<HTML;
                    </div>
HTML
                $flag=1;
            }
        }
    close(IN);
}