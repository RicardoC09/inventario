<template>
    <div class="container-body">
        <div class="container-form">
            <!-- Card del formulario -->
            <b-card border-variant="light" header-tag="header">
                <template #header>
                    <h1 class="header-left">Reporte de documentos por expediente</h1>
                </template>
                <div>
                    <b-form @submit="onSubmit" @reset="onReset" v-if="show">
                        <div class="container-left">
                            <b-form-group
                                class="form-group-left"
                                id="input-group-1"
                                label="Seccion"
                                label-for="input-1"
                            >
                                <b-form-select
                                    id="input-1"
                                    v-model="form.seccion"
                                    :options="seccion"
                                    required
                                ></b-form-select>
                            </b-form-group>

                            <b-form-group
                                class="form-group-left"
                                id="input-group-2"
                                label="Subserie"
                                label-for="input-2"
                            >
                                <b-form-input
                                    id="input-2"
                                    v-model="form.subserie"
                                    type="text"
                                    required
                                    placeholder="Subserie"
                                ></b-form-input>
                            </b-form-group>

                            <b-form-group
                                class="form-group-left"
                                id="input-group-3"
                                label="Estado"
                                label-for="input-3"
                            >
                                <b-form-select
                                    id="input-3"
                                    v-model="form.estado"
                                    :options="estado"
                                    required
                                ></b-form-select>
                            </b-form-group>
                        </div>
                        <div class="container-center">
                            <b-form-group
                                class="form-group-center"
                                id="input-group-4"
                                label="subseccion"
                                label-for="input-4"
                            >
                                <b-form-select
                                    id="input-4"
                                    v-model="form.subseccion"
                                    :options="subseccion"
                                    required
                                ></b-form-select>
                            </b-form-group>

                            <b-form-group
                                class="form-group-center"
                                id="input-group-5"
                                label="NoExpediente"
                                label-for="input-5"
                            >
                                <b-form-input
                                    id="input-5"
                                    v-model="form.noexpediente"
                                    type="number"
                                    required
                                    placeholder="NoExpediente"
                                ></b-form-input>
                            </b-form-group>

                            <b-form-group
                                class="form-group-center"
                                id="input-group-6"
                                label="Fecha de creacion"
                                label-for="input-6"
                            >
                                <b-form-input
                                    id="input-6"
                                    v-model="form.fechaCreacion"
                                    type="date"
                                    required
                                    placeholder="Fecha de creacion"
                                ></b-form-input>
                            </b-form-group>
                        </div>

                        <div class="container-right">
                            <b-form-group
                                class="form-group-right"
                                id="input-group-7"
                                label="Serie"
                                label-for="input-7"
                            >
                                <b-form-input
                                    id="input-7"
                                    v-model="form.serie"
                                    type="text"
                                    required
                                    placeholder="Serie"
                                ></b-form-input>
                            </b-form-group>
                            <b-form-group
                                class="form-group-right"
                                id="input-group-8"
                                label="Nombre expediente"
                                label-for="input-8"
                            >
                                <b-form-input
                                    id="input-8"
                                    v-model="form.nombreExpediente"
                                    type="text"
                                    required
                                    placeholder="Nombre expediente"
                                ></b-form-input>
                            </b-form-group>

                            <b-form-group
                                class="form-group-right"
                                id="input-group-9"
                                label="Fecha de incorporacion"
                                label-for="input-9"
                            >
                                <b-form-input
                                    id="input-6"
                                    v-model="form.fechaIncorporacion"
                                    type="date"
                                    required
                                    placeholder="Fecha de incorporacion"
                                ></b-form-input>
                            </b-form-group>
                        </div>
                        <div class="container-button">
                            <b-button
                                href="#/menuExpediente"
                                class="btn-form-cancel"
                                variant="danger"
                            >Cancelar</b-button
                            >
                            <b-button type="submit" class="btn-form-submit" variant="primary"
                            >Crear</b-button
                            >
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
        name: "reporteDocumentalPorExpediente",
        data() {
            return {
                //Archivo subido
                file1: null,
                form: {
                    seccion: null,
                    subserie: "",
                    estado: null,
                    subseccion: null,
                    noexpediente: "",
                    fechaCreacion: "",
                    serie: "",
                    nombreExpediente: "",
                    fechaIncorporacion: "",
                    //checked: []
                },
                seccion: [
                    { text: "Seleccionar una seccion", value: null },
                    "Vicerrectoria academica ",
                    "Vicerrectoria academica",
                    "Vicerrectoria academica",
                ],
                estado: [
                    { text: "Seleccionar un estado", value: null },
                    "Abierto",
                    "Cerrado",
                    "Privado",
                ],
                subseccion: [
                    { text: "Seleccionar una subseccion", value: null },
                    "Facultad de ingeniera  ",
                    "Facultad de ingeniera ",
                    "Facultad de ingeniera ",
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
                this.form.seccion = null;
                this.form.subserie = "";
                this.form.estado = null;
                this.form.subseccion = null;
                this.form.noexpediente = "";
                this.form.fechaCreacio = "";
                this.form.serie = "";
                this.form.nombreExpediente = "";
                this.form.fechaIncorporacion = "";
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
        width: 15%;
    }
    .btn-form-cancel {
        background-color: #dfd4a6;
        color: #8f141b;
        border-radius: 20px;
        width: 15%;
    }
    .form-group-left {
        width: 60%;
        text-align: left;
    }
    .form-group-center {
        width: 60%;
        text-align: left;
    }
    .form-group-right {
        width: 60%;
        text-align: left;
    }
    .container-center {
        position: absolute;
        left: 40%;
        width: 33%;
    }
    .container-right {
        position: relative;
        text-align: right;
        width: 33%;
        left: 80%;
    }
    .container-left {
        position: absolute;
        text-align: left;
        width: 33%;
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
