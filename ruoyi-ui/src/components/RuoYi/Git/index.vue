<template>
  <div>
    <svg-icon icon-class="github" @click="goto" />
  </div>
</template>

<script>
export default {
  name: 'ProjectRepo',
  data() {
    return {
      url: 'https://github.com/chizipudong/teaching-resource-management-system'
    }
  },
  methods: {
    goto() {
      window.open(this.url)
    }
  }
}
</script>
