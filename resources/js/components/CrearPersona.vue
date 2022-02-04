<template>
    <div class="container-body">
        <div class="container-form">
            <!-- Card del formulario -->
            <b-card border-variant="light" header-tag="header">
                <template #header>
                    <h1 class="header-left">Crear persona</h1>
                </template>
                <div>
                    <b-form @submit="onSubmit" @reset="onReset" v-if="show">
                        <div class="container-left">
                            <b-form-group
                                class="form-group-left"
                                id="input-group-1"
                                label="Nombre"
                                label-for="input-1"
                            >
                                <b-form-input
                                    id="input-1"
                                    v-model="form.nombre"
                                    type="text"
                                    required
                                    placeholder="Nombre"
                                ></b-form-input>
                            </b-form-group>

                            <b-form-group
                                class="form-group-left"
                                id="input-group-2"
                                label="Apellidos"
                                label-for="input-2"
                            >
                                <b-form-input
                                    id="input-2"
                                    v-model="form.apellido"
                                    type="text"
                                    required
                                    placeholder="Apellidos"
                                ></b-form-input>
                            </b-form-group>
                        </div>
                        <div class="container-right">
                            <b-form-group
                                class="form-group-right"
                                id="input-group-3"
                                label="Cargo"
                                label-for="input-3"
                            >
                                <b-form-input
                                    id="input-1"
                                    v-model="form.cargo"
                                    type="text"
                                    required
                                    placeholder="Cargo"
                                ></b-form-input>
                            </b-form-group>
                            <b-form-group
                                class="form-group-right"
                                id="input-group-4"
                                label="Identificacion"
                                label-for="input-4"
                            >
                                <b-form-input
                                    id="input-4"
                                    v-model="form.identificacion"
                                    type="number"
                                    required
                                    placeholder="Identificacion"
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
        name: "crearPersona",
        data() {
            return {
                form: {
                    nombre: "",
                    apellido: "",
                    cargo: "",
                    identificacion: "",
                    //checked: []
                },
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
                this.form.nombre = "";
                this.form.apellido = "";
                this.form.fechaIncorporacion = "";
                this.form.identificacion = "";
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
