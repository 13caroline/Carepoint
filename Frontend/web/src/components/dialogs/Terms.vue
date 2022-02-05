<template>
  <div id="termos" class="termos">
    <v-dialog v-model="dialog" width="800px">
      <template v-slot:activator="{ on }">
        <span>
          Li e aceito os
          <a v-on="on">termos</a>
          e
          <a v-on="on">condições</a>
          de responsabilidade
        </span>
      </template>

      <v-card class="px-4">
        <v-card-title class="mt-4">
          Termos e Condições de privacidade
        </v-card-title>
        <v-divider></v-divider>
        <v-card-text class="mx-auto mt-6">
          <div class="infos">
            Ao aceder a esta aplicação, o utilizador declara ter lido,
            compreendido e aceite na íntegra e sem reservas os Termos de
            Utilização infra descritos, sem ser necessário qualquer
            consentimento posterior.
          </div>
          <br />
          <div class="infos">
            <span class="font-weight-bold">
              <v-icon small> fas fa-angle-right </v-icon> Quais as informações
              recolhidas e com que finalidade
            </span>
          </div>

          <div class="infos"> 
            <span>
              A utilização desta aplicação implica, necessariamente, o
              fornecimento de dados pessoais através do preenchimento de
              formulários on-line. Tais dados serão tratados para:
            </span>
          </div>

          <div class="infos">
            <span>
              <v-icon x-small class="mr-1"> fas fa-dot-circle</v-icon>
              <strong>Pedido de contacto</strong>: os dados pessoais serão
              tratados, mediante o seu consentimento, estabelecer contacto com
              os utilizadores e prestar qualquer tipo de esclarecimento ou
              informação solicitadas pelo mesmo.
            </span>
            <br />
            <span>
              <v-icon x-small class="mr-1"> fas fa-dot-circle</v-icon>
              <strong>Pedido de informações pessoais</strong>: os dados pessoais
              serão tratados, mediante o seu consentimento, para manter o
              regular funcionamento das atividades do Coder Dojo, nomeadamente a
              atribuição de mentor, integração em determinada turma, conteúdos
              lecionados.
            </span>
            <br />
            <span>
              <v-icon x-small class="mr-1"> fas fa-dot-circle</v-icon>
              <strong>Subscrição de notificações</strong>: os dados pessoais
              serão tratados, mediante o seu consentimento, para efeitos de
              envio de comunicações e informações relevantes, nomeadamente
              marcação de eventos futuros.
            </span>
          </div>
          <br />
          <div class="infos">
            <span class="font-weight-bold">
              <v-icon small> fas fa-angle-right </v-icon> A quem são divulgados
              os dados pessoais
            </span>
          </div>

          <div class="infos">
            <span>
              Os dados pessoais não serão divulgados ou transferidos para
              quaisquer entidades, sites, aplicações, exceto se for dado
              consentimento prévio, livre e explícito pelo utilizador.
            </span>
          </div>
          <br />
          <div class="infos">
            <span class="font-weight-bold">
              <v-icon small> fas fa-angle-right </v-icon> Acesso aos dados
              pessoais e contacto em caso de dúvidas
            </span>
          </div>

          <div class="infos">
            <span>
              Nos termos da legislação vigente, o utilizador poderá solicitar, a
              todo o tempo, o acesso aos dados pessoais que lhe digam respeito,
              bem como a sua retificação, limitação do seu tratamento,
              eliminação ou a portabilidade dos seus dados, ou ainda opor-se ao
              seu tratamento. O utilizador poderá ainda obter mais
              esclarecimentos acerca de que dados pessoais são objeto de
              tratamento por parte do Coder Dojo, sendo-lhe disponibilizada,
              caso a requeira, a informação dos dados em fase de tratamento,
              podendo o utilizador retirar o seu consentimento para o tratamento
              dos dados, não invalidando, contudo, o tratamento previamente
              consentido e efectuado. Para o exercício dos seus direitos, o
              utilizador deverá realizar um pedido escrito para os seguintes
              contactos:
            </span>
            <br />
            <span class="font-weight-bold">
              <v-icon small>fas fa-envelope</v-icon>
              carepointApp@gmail.com
            </span>
          </div>
          <br />
          <div class="infos">
            <span class="font-weight-bold">
              <v-icon small> fas fa-angle-right </v-icon> Durante quanto tempo
              são conservados os dados pessoais
            </span>
          </div>

          <div class="infos">
            <span>
              Os dados pessoais serão conservados tendo em consideração as
              respetivas finalidades e no estrito cumprimento dos prazos legais
              aplicáveis. Assim, e sempre que não exista uma exigência legal
              específica para o efeito, os dados serão conservados somente
              durante o período adequado e necessário para a prossecução das
              finalidades para as quais foram solicitados, exceto se for
              exercido, nos termos legais, o direito de eliminação ou de
              oposição.
            </span>
          </div>
          <br />
          <div class="infos">
            <span class="font-weight-bold">
              <v-icon small> fas fa-angle-right </v-icon> Segurança
            </span>
          </div>

          <div class="infos">
            <span>
              Sem prejuízo do compromisso por parte do Coder Dojo de
              confidencialidade dos dados pessoais, os utilizadores da presente
              aplicação declaram conhecer as características e os
              constrangimentos, limitações e defeitos da Internet, os quais
              podem perturbar ou inviabilizar o acesso em certos períodos.
              Ademais, os utilizadores aceitam correr os riscos inerentes à
              possibilidade de intromissão de terceiros não autorizados, bem
              como de eventuais vírus ou desvios e transferência da informação,
              sendo que nenhum elemento, funcionário, colaborador ou responsável
              do Coder Dojo poderão ser, em nenhuma circunstância e momento,
              responsabilizados por danos sofridos pelos utilizadores, quer
              estes tenham sido provocados ou não por terceiros, no âmbito dos
              serviços prestados pela aplicação. Assim, os utilizadores ao
              acederem ao presente serviço aceitam correr todos os riscos
              relacionados com o uso da Internet e inerentes à atividade de
              internauta, designadamente os acima mencionados. O utilizador
              compromete-se também a não fazer quaisquer operações que possam
              prejudicar o funcionamento da aplicação, nomeadamente aceder a uma
              conta e respetivos conteúdos sem autorização do titular da mesma,
              testar ou quebrar a vulnerabilidade dos mecanismos de segurança
              instalados ou tentar disseminar vírus ou programas que danifiquem
              e//ou contaminem o serviço ou ainda incentivar terceiros a
              fazê-lo. Por último, informa-se que a aplicação utiliza cookies
              permitindo uma navegação mais rápida e eficiente da mesma,
              eliminando a necessidade de introduzir repetidamente as mesmas
              informações. Por conseguinte, os utilizadores ao instalarem a
              aplicação conhecem e aceitam sem reservas a sua utilização.
            </span>
          </div>
          <br />
          <div class="infos">
            <span class="font-weight-bold">
              <v-icon small> fas fa-angle-right </v-icon> Links para sítios de
              terceiros
            </span>
          </div>

          <div class="infos">
            <span>
              Os links constantes da aplicação podem conduzir a outros sítios. O
              Coder Dojo não se responsabiliza pelo conteúdo desses sítios, nem
              por danos resultantes de vírus ou outro malware que possam infetar
              o computador ou a rede do utilizador, ou outros bens.
            </span>
          </div>
          <br />
          <div class="infos">
            <span class="font-weight-bold">
              <v-icon small> fas fa-angle-right </v-icon> Alterações à política
              de privacidade e política de cookies
            </span>
          </div>

          <div class="infos">
            <span>
              O Coder Dojo reserva-se o direito de, a todo o momento, alterar os
              presentes termos de tratamento de dados pessoais. Essas alterações
              serão devidamente dadas a conhecer através da aplicação.
            </span>
          </div>
          <br />
          <div class="infos">
            <span class="font-weight-bold">
              <v-icon small> fas fa-angle-right </v-icon> Disponibilidade da
              Aplicação e Responsabilidade
            </span>
          </div>

          <div class="infos">
            <span>
              O Coder Dojo reserva-se o direito exclusivo de, a todo tempo,
              realizar alterações e correções, suspender, parcial ou totalmente,
              interromper ou encerrar, a qualquer momento, o acesso à aplicação
              quando o considerar adequado, sem necessidade de pré-aviso e pelo
              período que considerar necessário, por quaisquer razões de ordem
              técnica, administrativa, de gestão, de força maior ou outra, não
              podendo por tal ser responsabilizado. Ademais, o Coder Dojo não
              será responsável por erros que possam ocorrer devido a
              irregularidades do sistema ou falha, temporária ou permanente, da
              aplicação. O Coder Dojo também não se responsabilizará por
              quaisquer danos resultantes da utilização indevida ou da
              impossibilidade de utilização da sua aplicação.
            </span>
          </div>
          <br />
          <div class="infos">O presente termo tem prazo de validade indeterminado.</div>

          <div class="infos">
            Ao clicar "li e aceito os termos e condições de privacidade", assume
            plenamente os deveres que nele costam.
          </div>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="#78C4D4" text @click="dialog = false">Fechar</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
export default {
  data() {
    return {
      dialog: false,
    };
  },
};
</script>

<style scoped>
.infos {
  text-align: justify;
  text-justify: auto;
}

</style>