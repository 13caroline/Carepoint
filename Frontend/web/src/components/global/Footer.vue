<template>
  <div class="mt-16 pt-16 pt-sm-16 pt-md-16 pt-lg-16 pt-xl-16">
    <v-footer dark absolute v-bind:class="{ 'mt-10': marginTop }">
      <v-col class="text-center" cols="12">
        <p class="caption font-weight-light">
          Copyright &copy; {{ new Date().getFullYear() }} - Todos os direitos
          reservados — <strong>Carepoint</strong>
        </p>
      </v-col>
    </v-footer>
  </div>
</template>

<script>
export default {
  props: {
    marginTop: {
      type: Boolean,
      default: true,
    },
  },
};
</script>

