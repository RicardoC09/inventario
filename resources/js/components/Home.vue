<template>
  <div>
    <div>
      <!-- Segundo Header -->
      <nav class="navbar-medio">
        <p class="text-titulo text-uppercase">{{ $route.name }}</p>
      </nav>
    </div>

 

    
  </div>
</template>
<script>

export default {
   
  name: "CrearSeries",
  

  data() {
    return {
      
    };
  },



  
};
</script>
<style scoped>
.navbar-medio {
  position: absolute;
  left: 0;
  top: 70px;
  height: 70px;
  width: 100%;
  /*z-index: 1;*/
  background-color: transparent;
  padding-left: 0 !important;
  padding-right: 0 !important;
  background-color: #ffffff;
  border: 1px solid #f4f5f6;
}
.text-titulo {
  position: relative;
  text-align: center;
  color: #8f141b;
  font-weight: bolder;
  font-size: x-large;
  top: 11px;
}
</style>