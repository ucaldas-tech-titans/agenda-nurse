const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

exports.addMessage = functions.https.onRequest(async (req, res) => {
  // Obtener el parámetro de consulta 'text' de la solicitud HTTP
  const original = req.query.text;

  try {
    // Agregar un nuevo documento en la colección 'messages' en Firestore
    const writeResult = await admin.firestore().collection('messages').add({ original });
    // Enviar una respuesta JSON con el resultado exitoso
    res.json({ result: `Mensaje con ID: ${writeResult.id} agregado.` });
  } catch (error) {
    // En caso de error, enviar una respuesta con el código de error y el mensaje de error
    console.error('Error al agregar el mensaje:', error);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
});
