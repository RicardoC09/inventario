<template>
    <div class="container-body">
        <div class="container-form">
            <!-- Card del formulario -->
            <b-card border-variant="light" header-tag="header">
                <template #header>
                    <h1 class="header-left">Crear usuario</h1>
                </template>
                <div>
                    <b-form @submit="onSubmit" @reset="onReset" v-if="show">
                        <div class="container-left">
                            <b-form-group
                                class="form-group-left"
                                id="input-group-1"
                                label="Email"
                                label-for="input-1"
                            >
                                <b-form-input
                                    id="input-1"
                                    v-model="form.email"
                                    type="email"
                                    required
                                    placeholder="email"
                                ></b-form-input>
                            </b-form-group>

                            <b-form-group
                                class="form-group-left"
                                id="input-group-2"
                                label="Rol"
                                label-for="input-2"
                            >
                                <b-form-select
                                    id="input-2"
                                    v-model="form.rol"
                                    :options="rol"
                                    required
                                ></b-form-select>
                            </b-form-group>
                            <!--Subir Archivos-->
                            <b-form-group
                                class="form-group-right"
                                id="input-group-5"
                                label="Subir archivos pdf"
                                label-for="input-5"

                            >
                                <b-form-file
                                    v-model="file1"
                                    :state="Boolean(file1)"
                                    placeholder="Elegir una foto de perfil"
                                    drop-placeholder="Imagen aquí"
                                    required
                                ></b-form-file>
                            </b-form-group>
                        </div>
                        <div class="container-right">
                            <b-form-group
                                class="form-group-right"
                                id="input-group-3"
                                label="Contraseña"
                                label-for="input-3"
                            >
                                <b-form-input
                                    id="input-1"
                                    v-model="form.contrasena"
                                    type="password"
                                    required
                                    placeholder="Contraseña"
                                ></b-form-input>
                            </b-form-group>
                            <b-form-group
                                class="form-group-right"
                                id="input-group-4"
                                label="Repetir contraseña"
                                label-for="input-4"
                            >
                                <b-form-input
                                    id="input-4"
                                    v-model="form.repetirContrasena"
                                    type="password"
                                    required
                                    placeholder="Repetir contraseña"
                                ></b-form-input>
                            </b-form-group>
                            <!-- <b-form-group id="input-group-4">
                      <b-form-checkbox-group v-model="form.checked" id="checkboxes-4">
                        <b-form-checkbox value="me">Check me out</b-form-checkbox>
                        <b-form-checkbox value="that">Check that out</b-form-checkbox>
                      </b-form-checkbox-group>
                    </b-form-group>-->
                            <div class="container-button">
                                <b-button
                                    href="#/Usuario"
                                    class="btn-form-cancel"
                                    variant="danger"
                                >Cancelar</b-button
                                >
                                <b-button
                                    href="#/CrearUsuario"
                                    type="submit"
                                    class="btn-form-submit"
                                    variant="primary"
                                >Siguiente</b-button
                                >
                            </div>
                        </div>
                    </b-form>
                    <!-- Mostrar datos -->
                    <!--<b-card class="mt-3" header="Form Data Result">
                     <pre class="m-0">{{ form }}</pre>
                   </b-card>-->
                </div>
            </b-card>
        </div>
    </div>
</template>
<script>
    export default {
        name: "crearUsuario",
        data() {
            return {
                form: {
                    email: "",
                    rol: null,
                    contrasena: "",
                    repetirContrasena: "",
                    //checked: []
                },
                rol: [
                    { text: "Seleccionar un rol", value: null },
                    "Administrador",
                    "Cliente",
                ],
                show: true,
            };
        },
        methods: {
            onSubmit(evt) {
                evt.preventDefault();
                alert(JSON.stringify(this.form));
            },
            onReset(evt) {
                evt.preventDefault();
                // Reset our form values
                this.form.email = "";
                this.form.rol = null;
                this.form.contrasena = "";
                this.form.repetirContrasena = "";
            },
        },
    };
</script>
<style scoped>
    .container-card {
        width: 50%;
    }
    .btn-form-submit {
        background-color: #8f141b;
        color: #dfd4a6;
        border-radius: 20px;
        width: 30%;
    }
    .btn-form-cancel {
        background-color: #dfd4a6;
        color: #8f141b;
        border-radius: 20px;
        width: 30%;
    }
    .form-group-left {
        width: 60%;
        text-align: left;
    }
    .form-group-right {
        width: 60%;
        text-align: left;
    }
    .container-right {
        float: right;
        width: 50%;
    }
    .container-left {
        float: left;
        width: 50%;
    }
    .container-button {
        position: relative;
        text-align: center;
    }
    .header-left {
        float: left;
        font-size: 1rem;
        font-weight: 400;
        line-height: 1.5;
        color: #525f7f;
    }
    .header-right {
        float: right;
        font-size: 1rem;
        font-weight: 400;
        line-height: 1.5;
        color: #525f7f;
    }
</style>
