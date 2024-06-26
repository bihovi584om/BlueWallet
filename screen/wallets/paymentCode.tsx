import { NativeStackScreenProps } from '@react-navigation/native-stack';
import React from 'react';
import { StyleSheet, Text, View } from 'react-native';
import { PaymentCodeStackParamList } from '../../Navigation';
import QRCodeComponent from '../../components/QRCodeComponent';
import loc from '../../loc';
import CopyTextToClipboard from '../../components/CopyTextToClipboard';

type Props = NativeStackScreenProps<PaymentCodeStackParamList, 'PaymentCode'>;

export default function PaymentCode({ route }: Props) {
  const { paymentCode } = route.params;

  return (
    <View style={styles.container}>
      {!paymentCode && <Text>{loc.bip47.not_found}</Text>}
      {paymentCode && (
        <>
          <QRCodeComponent value={paymentCode} />
          <CopyTextToClipboard text={paymentCode} truncated={false} />
        </>
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});
