<template>
  <div id="InicioSesion">
    <body>
      <div class="div_ingresar">
        <div class="contenido_iniciar">
          <div class="div_contenido_iniciar">
            <h1 class="texto_iniciar_sesion">Iniciar sesión</h1>
            <div>
              <!-- Usuario -->
              <div>
                <b-form @submit.stop.prevent>
                  <label for="feedback-user"></label>
                  <b-input
                    placeholder="Email"
                    v-model="userId"
                    :state="validation"
                    id="feedback-user"
                  ></b-input>
                  <b-form-invalid-feedback :state="validation">
                    Su correo debe ser entre 5 y 20 caracteres
                  </b-form-invalid-feedback>
                  <b-form-valid-feedback :state="validation">
                    Correcto
                  </b-form-valid-feedback>
                </b-form>
              </div>
              <!-- Contraseña -->
              <div>
                <b-form @submit.stop.prevent>
                  <label for="text-password"></label>
                  <b-input
                    placeholder="Contraseña"
                    type="password"
                    id="text-password"
                    aria-describedby="password-help-block"
                  ></b-input>
                  <b-form-text id="password-help-block">
                    Su contraseña debe tener entre 8 y 20 caracteres, contener
                    letras y números, y no debe contener espacios, caracteres
                    especiales ni emoji.
                  </b-form-text>
                </b-form>
              </div>
              <div></div>
              <div>
                <div class="texto_olvido_contrasena">
                  <h1>¿Olvidó su contraseña?</h1>
                </div>
                <div>
                  <b-button class="boton_ingresar">Ingresar</b-button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </body>
  </div>
</template>

<script>
export default {
  name: "LoginV2",
  /* usuario */
  data() {
    return {
      userId: "",
    };
  },
  computed: {
    validation() {
      return this.userId.length > 4 && this.userId.length < 40;
    },
  },
};
</script>
<style scoped>
html,
body {
  padding: 0px;
  margin: 0px;
  width: 100%;
  height: 100vh;
}
.boton_ingresar {
  background-color: #8f141b;
  color: #dfd4a6;
  border: 5%;
}
.texto_iniciar_sesion {
  color: #4e6470;
  font-size: x-large;
}
.texto_olvido_contrasena h1 {
  line-height: 50pt;
  color: #4e6470;
  font-size: medium;
  text-align: left;
}
.div_ingresar {
  background-color: #8f141b;
  width: 100%;
  height: 100vh;
  align-content: center;
  align-items: center;
  display: flex;
}
.div_ingresar .contenido_iniciar {
  width: 100%;
  text-align: center;
}
.div_ingresar .contenido_iniciar .div_contenido_iniciar {
  max-width: 600px;
  width: 100%;
  background: #f7fafc;
  padding: 20px;
  border-radius: 15px;
  display: inline-block;
}
</style> 