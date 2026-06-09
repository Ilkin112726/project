import React from 'react';
import { motion } from 'framer-motion';
import { useTheme } from '@/lib/ThemeContext';
import { t } from '@/lib/i18n';
import { CURRENCIES, getExchangeRate } from '@/lib/currency';

export default function ExchangeRatesWidget() {
  const { currency, language } = useTheme();
  const pairs = Object.keys(CURRENCIES).filter((c) => c !== currency).slice(0, 4);

  return (
    <div>
      <h3 className="text-sm font-semibold text-foreground mb-3">{t('exchangeRates', language)}</h3>
      <div className="grid grid-cols-2 gap-2">
        {pairs.map((code, i) => {
          const rate = getExchangeRate(currency, code);
          const c = CURRENCIES[code];
          return (
            <motion.div
              key={code}
              initial={{ opacity: 0, scale: 0.95 }}
              animate={{ opacity: 1, scale: 1 }}
              transition={{ delay: i * 0.05 }}
              className="p-3 rounded-xl bg-card border border-border"
            >
              <div className="flex items-center gap-2 mb-1.5">
                <span className="text-base">{c.flag}</span>
                <span className="text-xs font-semibold text-foreground">{code}</span>
              </div>
              <p className="text-sm font-bold text-foreground tabular-nums">{rate.toFixed(4)}</p>
              <p className="text-[10px] text-muted-foreground">1 {currency} = {rate.toFixed(4)} {code}</p>
            </motion.div>
          );
        })}
      </div>
    </div>
  );
}
