<template>
<div class="contenedor-header">
 <div class="navbar-medio " >       
<p class="text-titulo text-uppercase">{{$route.name}}</p>

</div>
<div class="navbar-final " >       
<div class="input-group">
  <input type="text" class="form-control" placeholder="Recipient's username" aria-label="Recipient's username with two button addons" aria-describedby="button-addon4">
  <div class="input-group-append" id="button-addon4">
    <button class="btn btn-outline-secondary" type="button">Button</button>
    <button class="btn btn-outline-secondary" type="button">Button</button>
  </div>
</div>

</div>
</div>
</template>
<script>
export default {    
name: "TituloLayout",
 
}
</script>
<style scoped>
.text-titulo{
  color:#8F141B;
  font-size:xx-large;
  font-weight: bolder;
  text-align: center;
  height: 100%;
}
.contenedor-header{
  width: 500px;
}
</style>