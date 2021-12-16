<template>
  <div class="mt-auto">
    <v-footer dark fixed>
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