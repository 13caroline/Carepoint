<template>
  <div>
    <v-container class="fill-height">
      <v-row justify="center">
        <v-col cols="8">
          <v-row class="w-100">
            <h3 class="font-weight-regular text-uppercase">
              Registar como Prestador de Cuidados Individual
            </h3>
          </v-row>
          <v-row class="w-100">
            <p class="body-2">Por favor preencha o seguinte formulário</p>
          </v-row>

          <v-form ref="form" v-model="valid" lazy-validation>
            <span>Nome completo *</span>
            <v-text-field
              outlined
              flat
              dense
              single-line
              :rules="textRules"
              color="#2596be"
              v-model="nome"
              name="nome"
              required
            />

            <span>E-mail *</span>
            <v-text-field
              outlined
              flat
              dense
              v-model="email"
              single-line
              :rules="emailRules"
              color="#2596be"
              name="email"
              required
            />

            <v-row class="mt-1">
              <v-col cols="12" sm="6" class="py-0">
                <span>Palavra-passe *</span>
                <v-text-field
                  outlined
                  flat
                  dense
                  v-model="password"
                  single-line
                  color="#2596be"
                  name="password"
                  type="password"
                  required
                />
              </v-col>
              <v-col class="py-0">
                <span>Repetir palavra-passe *</span>
                <v-text-field
                  outlined
                  flat
                  dense
                  single-line
                  v-model="password2"
                  :rules="textRules"
                  color="#2596be"
                  type="password"
                  required
                />
              </v-col>
            </v-row>

            <v-row align="end" class="mb-1">
              <v-col cols="auto" class="dial_code py-0">
                <v-text-field
                  outlined
                  flat
                  background-color="#E0E0E0"
                  dense
                  single-line
                  color="#2596be"
                  value="+351"
                  readonly
                />
              </v-col>
              <v-col class="py-0">
                <span>Contacto telefónico *</span>
                <v-text-field
                  outlined
                  flat
                  dense
                  single-line
                  color="#2596be"
                  name="contacto"
                  v-model="contacto"
                  :rules="numberRules"
                  maxlength="9"
                  required
                />
              </v-col>
              <v-col cols="12" sm class="py-0">
                <span>Experiência *</span>
                <v-text-field
                  outlined
                  flat
                  dense
                  single-line
                  color="#2596be"
                  name="experiencia"
                  v-model="experiencia"
                  suffix="anos"
                  maxlength="9"
                  required
                />
              </v-col>
            </v-row>
            
          </v-form>
          <span class="ma-0 caption">* Campos obrigatórios</span>
          <v-row align="end" justify="end">
           <!-- <v-col cols="auto" class="pr-0">
              <Cancelar :dialogs="cancelar" @clicked="close()"></Cancelar>
            </v-col>
            <v-col cols="auto" class="pl-0">
              <v-btn color="#2596be" small dark class="ml-3" @click="registar()"
                >Registar</v-btn
              >
            </v-col>-->
          </v-row>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
export default {
  name: "SingleSPForm",
  data() {
    return {};
  },
};
</script>

<style scoped>
h3 {
  color: #78c4d4;
}
</style>


