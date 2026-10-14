// Redragon Studio — K530 Draconic Control Center

const KEY_LAYOUT = [
  // Row 0
  [
    { id: 'esc', base: 'Esc', shift: '`', fn1: '~', fn2: 'Battery', w: '' },
    { id: 'k1', base: '1', shift: '!', fn1: 'F1', fn2: '10%', w: '' },
    { id: 'k2', base: '2', shift: '@', fn1: 'F2', fn2: '20%', w: '' },
    { id: 'k3', base: '3', shift: '#', fn1: 'F3', fn2: '30%', w: '' },
    { id: 'k4', base: '4', shift: '$', fn1: 'F4', fn2: '40%', w: '' },
    { id: 'k5', base: '5', shift: '%', fn1: 'F5', fn2: '50%', w: '' },
    { id: 'k6', base: '6', shift: '^', fn1: 'F6', fn2: '60%', w: '' },
    { id: 'k7', base: '7', shift: '&', fn1: 'F7', fn2: '70%', w: '' },
    { id: 'k8', base: '8', shift: '*', fn1: 'F8', fn2: 'Color 🎨', w: '' },
    { id: 'k9', base: '9', shift: '(', fn1: 'F9', fn2: 'Mode 💫', w: '' },
    { id: 'k0', base: '0', shift: ')', fn1: 'F10', fn2: 'Light ⚡', w: '' },
    { id: 'minus', base: '-', shift: '_', fn1: 'F11', fn2: 'Bright -', w: '' },
    { id: 'equal', base: '=', shift: '+', fn1: 'F12', fn2: 'Bright +', w: '' },
    { id: 'backspace', base: 'Backspace', fn1: 'Delete', fn2: '', w: 'w-200' }
  ],
  // Row 1
  [
    { id: 'tab', base: 'Tab', fn1: '', fn2: '', w: 'w-150' },
    { id: 'q', base: 'Q', fn1: 'BT1 📶', fn2: '', w: '' },
    { id: 'w', base: 'W', fn1: '▲ Up', fn2: '', w: '' },
    { id: 'e', base: 'E', fn1: 'BT3 📶', fn2: '', w: '' },
    { id: 'r', base: 'R', fn1: '2.4G 📡', fn2: '', w: '' },
    { id: 't', base: 'T', fn1: '', fn2: '', w: '' },
    { id: 'y', base: 'Y', fn1: '', fn2: '', w: '' },
    { id: 'u', base: 'U', fn1: '', fn2: '', w: '' },
    { id: 'i', base: 'I', fn1: 'PrtSc', fn2: '', w: '' },
    { id: 'o', base: 'O', fn1: 'ScrLk', fn2: '', w: '' },
    { id: 'p', base: 'P', fn1: 'Pause', fn2: '', w: '' },
    { id: 'bracket_l', base: '[', shift: '{', fn1: 'Home', fn2: 'Speed -', w: '' },
    { id: 'bracket_r', base: ']', shift: '}', fn1: 'End', fn2: 'Speed +', w: '' },
    { id: 'backslash', base: '\\', shift: '|', fn1: 'Insert', fn2: 'DIY 💡', w: 'w-150' }
  ],
  // Row 2
  [
    { id: 'caps', base: 'Caps Lock', fn1: 'Magic Fn', fn2: '', w: 'w-175' },
    { id: 'a', base: 'A', fn1: '◀ Left', fn2: '', w: '' },
    { id: 's', base: 'S', fn1: '▼ Down', fn2: '', w: '' },
    { id: 'd', base: 'D', fn1: '▶ Right', fn2: '', w: '' },
    { id: 'f', base: 'F', fn1: '', fn2: '', w: '' },
    { id: 'g', base: 'G', fn1: '', fn2: '', w: '' },
    { id: 'h', base: 'H', fn1: '', fn2: '', w: '' },
    { id: 'j', base: 'J', fn1: 'Insert', fn2: '', w: '' },
    { id: 'k', base: 'K', fn1: 'Home', fn2: '', w: '' },
    { id: 'l', base: 'L', fn1: 'PgUp', fn2: '', w: '' },
    { id: 'semicolon', base: ';', shift: ':', fn1: 'PgDn', fn2: '', w: '' },
    { id: 'quote', base: '\'', shift: '"', fn1: 'Delete', fn2: '', w: '' },
    { id: 'enter', base: 'Enter', fn1: '', fn2: '', w: 'w-225' }
  ],
  // Row 3
  [
    { id: 'shift_l', base: 'Shift', fn1: '', fn2: '', w: 'w-225' },
    { id: 'z', base: 'Z', fn1: '', fn2: '', w: '' },
    { id: 'x', base: 'X', fn1: '', fn2: '', w: '' },
    { id: 'c', base: 'C', fn1: '', fn2: '', w: '' },
    { id: 'v', base: 'V', fn1: '', fn2: '', w: '' },
    { id: 'b', base: 'B', fn1: '', fn2: '', w: '' },
    { id: 'n', base: 'N', fn1: '', fn2: '', w: '' },
    { id: 'm', base: 'M', fn1: '', fn2: '', w: '' },
    { id: 'comma', base: ',', shift: '<', fn1: '', fn2: '', w: '' },
    { id: 'period', base: '.', shift: '>', fn1: 'Delete', fn2: '', w: '' },
    { id: 'slash', base: '/', shift: '?', fn1: 'Insert', fn2: '', w: '' },
    { id: 'shift_r', base: 'Shift', fn1: '▲ Arrow', fn2: '', w: 'w-275' }
  ],
  // Row 4
  [
    { id: 'ctrl_l', base: 'Ctrl', fn1: '', fn2: '', w: 'w-125' },
    { id: 'win_l', base: 'Win', macBase: 'Option ⌥', fn1: '', fn2: '', w: 'w-125' },
    { id: 'alt_l', base: 'Alt', macBase: 'Command ⌘', fn1: '', fn2: '', w: 'w-125' },
    { id: 'space', base: 'Space', fn1: '', fn2: 'Reset (3s)', w: 'w-625' },
    { id: 'alt_r', base: 'Alt', macBase: 'Cmd ⌘', fn1: '', fn2: '', w: 'w-125' },
    { id: 'fn1', base: 'Fn1', fn1: 'Active', fn2: '', w: 'w-125' },
    { id: 'fn2', base: 'Fn2', fn1: '', fn2: 'Active', w: 'w-125' },
    { id: 'ctrl_r', base: 'Ctrl', fn1: '', fn2: '', w: 'w-125' }
  ]
];

const RGB_MODES = [
  { id: 'neon', name: 'Neon Stream', desc: 'Flowing vibrant multi-color wave', anim: 'anim-neon' },
  { id: 'wave', name: 'Flowing Wave', desc: 'Smooth full RGB spectrum cycle', anim: 'anim-wave' },
  { id: 'breathing', name: 'Breathing Pulse', desc: 'Rhythmic pulsing glow', anim: 'anim-breathing' },
  { id: 'ripple', name: 'Reactive Ripple', desc: 'Wave spreads from pressed key', anim: 'anim-ripple' },
  { id: 'reactive', name: 'Single Reactive', desc: 'Key lights up when pressed', anim: 'anim-reactive' },
  { id: 'aurora', name: 'Aurora Spectrum', desc: 'Synchronized hue transition', anim: 'anim-wave' },
  { id: 'raindrops', name: 'Starry Raindrops', desc: 'Random keys twinkle softly', anim: 'anim-raindrops' },
  { id: 'radar', name: 'Radar Beam', desc: 'Sweeping radar rotation', anim: 'anim-wave' },
  { id: 'static', name: 'Solid Static', desc: 'Clean constant illumination', anim: '' },
  { id: 'diy', name: 'Custom DIY', desc: 'Per-key hardware memory layout', anim: '' },
  { id: 'off', name: 'Backlight Off', desc: 'LEDs off for maximum battery', anim: '' }
];

const RGB_COLORS = [
  { name: 'Spectrum Rainbow', hex: 'linear-gradient(135deg, #ff1e38, #00f0ff, #ffee00)' },
  { name: 'Crimson Red', hex: '#ff1e38' },
  { name: 'Flame Orange', hex: '#ff8800' },
  { name: 'Golden Yellow', hex: '#ffd700' },
  { name: 'Emerald Green', hex: '#00ff66' },
  { name: 'Cyan Aqua', hex: '#00f0ff' },
  { name: 'Royal Blue', hex: '#1e66ff' },
  { name: 'Purple Magenta', hex: '#cc00ff' },
  { name: 'Crisp White', hex: '#ffffff' }
];

// App State
let state = {
  connected: false,
  currentLayer: 'base', // 'base', 'fn1', 'fn2'
  swapCmdOpt: true,
  swapRightMod: false,
  capsLockAction: 'normal',
  launchOnLogin: true,
  currentMode: 'neon',
  currentColor: RGB_COLORS[0],
  brightness: 5,
  speed: 3
};

// DOM Elements
const keyboardPlate = document.getElementById('keyboardPlate');
const keyInspectTooltip = document.getElementById('keyInspectTooltip');
const statusIndicator = document.getElementById('statusIndicator');
const deviceNameDisplay = document.getElementById('deviceNameDisplay');
const connectionTypeDisplay = document.getElementById('connectionTypeDisplay');
const swapCmdOptToggle = document.getElementById('swapCmdOptToggle');
const swapRightModToggle = document.getElementById('swapRightModToggle');
const capsLockSelect = document.getElementById('capsLockSelect');
const launchOnLoginToggle = document.getElementById('launchOnLoginToggle');
const currentEffectName = document.getElementById('currentEffectName');
const currentColorName = document.getElementById('currentColorName');
const colorPreviewCircle = document.getElementById('colorPreviewCircle');
const toast = document.getElementById('toast');
const toastMsg = document.getElementById('toastMsg');

// Initialize Keyboard Visualizer
function renderKeyboard() {
  keyboardPlate.innerHTML = '';

  KEY_LAYOUT.forEach((row, rIdx) => {
    const rowEl = document.createElement('div');
    rowEl.className = 'kb-row';

    row.forEach(key => {
      const keyEl = document.createElement('div');
      keyEl.className = `kb-key ${key.w}`;
      keyEl.dataset.id = key.id;

      // Determine label based on layer and Mac swap
      let primaryText = key.base;
      let subText = '';

      if (state.currentLayer === 'base') {
        if (state.swapCmdOpt && (key.id === 'alt_l' || key.id === 'win_l')) {
          primaryText = key.macBase;
          keyEl.classList.add('mac-swapped');
        } else if (state.swapRightMod && key.id === 'alt_r') {
          primaryText = key.macBase;
          keyEl.classList.add('mac-swapped');
        } else if (state.capsLockAction === 'escape' && key.id === 'caps') {
          primaryText = 'Esc (Vim)';
          keyEl.classList.add('mac-swapped');
        }
        subText = key.shift || '';
      } else if (state.currentLayer === 'fn1') {
        primaryText = key.fn1 || key.base;
        subText = key.fn1 ? 'Fn1' : '';
      } else if (state.currentLayer === 'fn2') {
        primaryText = key.fn2 || key.base;
        subText = key.fn2 ? 'Fn2' : '';
      }

      keyEl.innerHTML = `
        <span class="kb-primary">${primaryText}</span>
        ${subText ? `<span class="kb-sub">${subText}</span>` : ''}
      `;

      // Apply key color styling
      if (state.currentColor.hex.includes('gradient')) {
        const hue = ((rIdx * 15 + parseInt(key.id.replace(/\D/g, '') || 5) * 22) % 360);
        keyEl.style.borderColor = `hsl(${hue}, 90%, 60%)`;
        keyEl.style.color = `hsl(${hue}, 90%, 75%)`;
      } else {
        keyEl.style.borderColor = state.currentColor.hex;
        keyEl.style.color = state.currentColor.hex;
      }

      // Interaction
      keyEl.addEventListener('mouseenter', () => inspectKey(key));
      keyEl.addEventListener('click', () => {
        keyEl.style.transform = 'translateY(2px)';
        keyEl.style.boxShadow = `0 0 15px ${state.currentColor.hex.includes('gradient') ? '#ff1e38' : state.currentColor.hex}`;
        setTimeout(() => {
          keyEl.style.transform = '';
          keyEl.style.boxShadow = '';
        }, 150);
        inspectKey(key);
      });

      rowEl.appendChild(keyEl);
    });

    keyboardPlate.appendChild(rowEl);
  });
}

function inspectKey(key) {
  let text = `Key [${key.base}]: Base Layer = ${key.base}`;
  if (key.shift) text += ` | Shift = ${key.shift}`;
  if (key.fn1) text += ` | Fn1 = ${key.fn1}`;
  if (key.fn2) text += ` | Fn2 (Hardware) = ${key.fn2}`;
  if (state.swapCmdOpt && key.id === 'alt_l') text += ` ➔ Mapped to Command (⌘) on Mac!`;
  if (state.swapCmdOpt && key.id === 'win_l') text += ` ➔ Mapped to Option (⌥) on Mac!`;
  keyInspectTooltip.textContent = text;
}

// Layer Selector
document.querySelectorAll('.layer-btn').forEach(btn => {
  btn.addEventListener('click', () => {
    document.querySelectorAll('.layer-btn').forEach(b => b.classList.remove('active'));
    btn.classList.add('active');
    state.currentLayer = btn.dataset.layer;
    renderKeyboard();
  });
});

// Mode Selector Grid
function initModes() {
  const modeGrid = document.getElementById('modeGrid');
  modeGrid.innerHTML = '';
  RGB_MODES.forEach(mode => {
    const card = document.createElement('div');
    card.className = `mode-card ${state.currentMode === mode.id ? 'active' : ''}`;
    card.innerHTML = `
      <span class="mode-name">${mode.name}</span>
      <span class="mode-desc">${mode.desc}</span>
    `;
    card.addEventListener('click', () => {
      document.querySelectorAll('.mode-card').forEach(c => c.classList.remove('active'));
      card.classList.add('active');
      state.currentMode = mode.id;
      currentEffectName.textContent = mode.name;

      // Update animation class on keyboard
      keyboardPlate.className = 'keyboard-plate';
      if (mode.anim) {
        keyboardPlate.classList.add(mode.anim);
      }
      showToast(`Selected "${mode.name}". Press Fn2 + 9 on keyboard to match!`);
    });
    modeGrid.appendChild(card);
  });
}

// Color Palette
function initColors() {
  const colorPalette = document.getElementById('colorPalette');
  colorPalette.innerHTML = '';
  RGB_COLORS.forEach((col, idx) => {
    const swatch = document.createElement('div');
    swatch.className = `color-swatch ${idx === 0 ? 'active' : ''}`;
    swatch.style.background = col.hex;
    swatch.title = col.name;
    swatch.addEventListener('click', () => {
      document.querySelectorAll('.color-swatch').forEach(s => s.classList.remove('active'));
      swatch.classList.add('active');
      state.currentColor = col;
      currentColorName.textContent = col.name;
      colorPreviewCircle.style.background = col.hex;
      renderKeyboard();
      showToast(`Selected ${col.name}. Cycle on board with Fn2 + 8`);
    });
    colorPalette.appendChild(swatch);
  });
}

// Tabs Switching
document.querySelectorAll('.tab-btn').forEach(btn => {
  btn.addEventListener('click', () => {
    document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
    document.querySelectorAll('.tab-pane').forEach(p => p.classList.remove('active'));
    btn.classList.add('active');
    const targetPane = document.getElementById(btn.dataset.tab);
    if (targetPane) targetPane.classList.add('active');
  });
});

// Settings & Native Bridge Calls
function sendToNative(action, params = {}) {
  const payload = { action, ...params };
  if (window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.redragonBridge) {
    window.webkit.messageHandlers.redragonBridge.postMessage(payload);
  } else {
    console.log('[Mock Native Send]', payload);
  }
}

// Apply Key Mapping Button
document.getElementById('applyMappingBtn').addEventListener('click', () => {
  state.swapCmdOpt = swapCmdOptToggle.checked;
  state.swapRightMod = swapRightModToggle.checked;
  state.capsLockAction = capsLockSelect.value;
  state.launchOnLogin = launchOnLoginToggle.checked;

  sendToNative('applyMapping', {
    swapCmdOpt: state.swapCmdOpt,
    swapRightMod: state.swapRightMod,
    capsLockAction: state.capsLockAction,
    launchOnLogin: state.launchOnLogin
  });

  renderKeyboard();
  showToast('✓ Mac Layout successfully applied to Redragon K530!');
});

// Reset Button
document.getElementById('resetMappingBtn').addEventListener('click', () => {
  swapCmdOptToggle.checked = false;
  swapRightModToggle.checked = false;
  capsLockSelect.value = 'normal';
  state.swapCmdOpt = false;
  state.swapRightMod = false;
  state.capsLockAction = 'normal';

  sendToNative('resetMapping');
  renderKeyboard();
  showToast('Reset to Windows default layout.');
});

// Toggles change triggers
swapCmdOptToggle.addEventListener('change', () => {
  state.swapCmdOpt = swapCmdOptToggle.checked;
  renderKeyboard();
});

capsLockSelect.addEventListener('change', () => {
  state.capsLockAction = capsLockSelect.value;
  renderKeyboard();
});

// Native Callback Receiver
window.onNativeStateUpdate = function(nativeState) {
  state.connected = nativeState.connected;
  state.swapCmdOpt = nativeState.swapCmdOpt;
  state.swapRightMod = nativeState.swapRightMod;
  state.capsLockAction = nativeState.capsLockAction;
  state.launchOnLogin = nativeState.launchOnLogin;

  // Sync UI elements
  swapCmdOptToggle.checked = state.swapCmdOpt;
  swapRightModToggle.checked = state.swapRightMod;
  capsLockSelect.value = state.capsLockAction;
  launchOnLoginToggle.checked = state.launchOnLogin;

  if (state.connected) {
    statusIndicator.className = 'status-indicator connected';
    deviceNameDisplay.textContent = 'Redragon K530';
    connectionTypeDisplay.textContent = 'Connected • BT5.0 KB (BLE)';
  } else {
    statusIndicator.className = 'status-indicator';
    deviceNameDisplay.textContent = 'Redragon K530';
    connectionTypeDisplay.textContent = 'Disconnected (Turn on BT)';
  }

  renderKeyboard();
};

function showToast(msg) {
  toastMsg.textContent = msg;
  toast.classList.add('show');
  setTimeout(() => {
    toast.classList.remove('show');
  }, 3200);
}

// Startup
document.addEventListener('DOMContentLoaded', () => {
  renderKeyboard();
  initModes();
  initColors();
  sendToNative('getState');
});

