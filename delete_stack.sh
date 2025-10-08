#!/bin/bash

# Variables genéricas para parametrizar el stack
STACK_NAME=${STACK_NAME:-juan-macias-stack}
REGION=${REGION:-us-east-1}
PROFILE=${PROFILE:-default}

echo "Eliminando stack: $STACK_NAME"
aws cloudformation delete-stack \
  --stack-name "$STACK_NAME" \
  --region "$REGION" \
  --profile "$PROFILE"

echo "Esperando a que el stack sea eliminado..."
aws cloudformation wait stack-delete-complete \
  --stack-name "$STACK_NAME" \
  --region "$REGION" \
  --profile "$PROFILE"

if [ $? -eq 0 ]; then
  echo "El stack $STACK_NAME fue eliminado correctamente."
else
  echo "Hubo un error al eliminar el stack $STACK_NAME."
fi
