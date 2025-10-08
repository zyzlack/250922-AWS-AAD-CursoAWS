## Scripts para gestionar la infraestructura con CloudFormation

Se incluyen scripts para crear y eliminar el stack de infraestructura en AWS de forma parametrizada y automática.

### Crear o actualizar el stack

Ejecuta el script `create_stack.sh` para crear el stack si no existe, o actualizarlo si ya existe:

```bash
./create_stack.sh
```

Puedes personalizar los parámetros usando variables de entorno:

```bash
STACK_NAME=mi-stack REGION=us-west-2 INSTANCE_TYPE=t2.micro ./create_stack.sh
```

Variables disponibles:
- STACK_NAME: Nombre del stack (por defecto: juan-macias-654654327431)
- TEMPLATE_BODY: Archivo de infraestructura (por defecto: infra.yml)
- REGION: Región de AWS (por defecto: us-east-1)
- PROFILE: Perfil de AWS CLI (por defecto: default)
- VPC_ID: ID de la VPC
- SUBNET_ID: ID de la subred
- INSTANCE_TYPE: Tipo de instancia EC2
- SECURITY_GROUP_ID: ID del grupo de seguridad

### Eliminar el stack

Ejecuta el script `delete_stack.sh` para eliminar el stack:

```bash
./delete_stack.sh
```

Puedes personalizar el nombre del stack y la región:

```bash
STACK_NAME=mi-stack REGION=us-west-2 ./delete_stack.sh
```

# Requerimientos de Diseño para la Infraestructura AWS

1. **Plantilla CloudFormation**
	- El archivo de infraestructura debe llamarse `infra.yml`.
	- La plantilla debe ser clara, modular y seguir buenas prácticas de nomenclatura y organización de recursos.

2. **Red (VPC)**
	- Utilizar la VPC por defecto de la cuenta, con el ID: `vpc-086fe118b4ed5c6e4`.
	- Todos los recursos deben estar asociados explícitamente a esta VPC.

3. **Instancia EC2**
	- Crear una instancia EC2 de tipo `t3.micro` (o el tipo T3 más adecuado según necesidades).
	- Etiquetar la instancia con el nombre `Nombre`.
	- Usar la imagen más reciente de Amazon Linux 2023, seleccionada dinámicamente según la región.
	- La instancia debe estar en una subred pública de la VPC por defecto.

4. **Seguridad**
	- No utilizar pares de claves SSH para acceso.
	- Crear un rol IAM específico para la instancia, con permisos mínimos necesarios (principio de menor privilegio).
	- Asociar el rol IAM creado a la instancia EC2.
	- Asociar el grupo de seguridad por defecto de la VPC a la instancia EC2.
	- Limitar el acceso entrante solo a los puertos y direcciones IP estrictamente necesarios.

5. **Buenas Prácticas**
	- Definir salidas (`Outputs`) relevantes en la plantilla, como el ID de la instancia, IP pública, etc.
	- Documentar cada recurso con comentarios en la plantilla.
	- Validar la plantilla con herramientas como `cfn-lint` antes de su despliegue.