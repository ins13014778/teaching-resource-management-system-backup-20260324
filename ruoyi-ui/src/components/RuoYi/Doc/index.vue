<template>
  <div>
    <svg-icon icon-class="question" @click="goto" />
  </div>
</template>

<script>
export default {
  name: 'ProjectDoc',
  data() {
    return {
      url: 'https://github.com/ins13014778/teaching-resource-management-system-backup-20260324'
    }
  },
  methods: {
    goto() {
      window.open(this.url)
    }
  }
}
</script>
